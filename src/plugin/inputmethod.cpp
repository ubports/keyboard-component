/*
 * This file is part of Maliit Plugins
 *
 * Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies). All rights reserved.
 *
 * Contact: Mohammad Anwari <Mohammad.Anwari@nokia.com>
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Nokia Corporation nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#include "inputmethod.h"
#include "inputmethod_p.h"

#include "models/key.h"
#include "models/keyarea.h"
#include "models/wordribbon.h"
#include "models/layout.h"

#include "logic/abstractlanguagefeatures.h"
// #include "logic/layouthelper.h"
//#include "logic/style.h"

#include "view/setup.h"

#include <maliit/plugins/subviewdescription.h>
#include <maliit/plugins/updateevent.h>
#include <maliit/namespace.h>

#include <QApplication>
#include <QWidget>
#include <QDesktopWidget>


class MImUpdateEvent;

using namespace MaliitKeyboard;

namespace {

const char * const actionKeyName = "actionKey";

Qt::ScreenOrientation rotationAngleToScreenOrientation(int angle)
{
    bool portraitIsPrimary = QGuiApplication::primaryScreen()->primaryOrientation()
        == Qt::PortraitOrientation;

    switch (angle) {
        case 0:
            return portraitIsPrimary ? Qt::PortraitOrientation
                                     : Qt::LandscapeOrientation;
            break;
        case 90:
            return portraitIsPrimary ? Qt::InvertedLandscapeOrientation
                                     : Qt::PortraitOrientation;
            break;
        case 180:
            return portraitIsPrimary ? Qt::InvertedPortraitOrientation
                                     : Qt::InvertedLandscapeOrientation;
            break;
        case 270:
        default:
            return portraitIsPrimary ? Qt::LandscapeOrientation
                                     : Qt::InvertedPortraitOrientation;
            break;
    }
}

const QString g_maliit_keyboard_qml(UBUNTU_KEYBOARD_DATA_DIR "/Keyboard.qml");

} // unnamed namespace

InputMethod::InputMethod(MAbstractInputMethodHost *host)
    : MAbstractInputMethod(host)
    , d_ptr(new InputMethodPrivate(this, host))
{
    Q_D(InputMethod);

    // FIXME: Reconnect feedback instance.
    Setup::connectAll(&d->event_handler, &d->editor);
    connect(&d->editor,  SIGNAL(autoCapsActivated()), this, SIGNAL(activateAutocaps()));
    connect(&d->editor,  SIGNAL(autoCapsDeactivated()), this, SIGNAL(deactivateAutocaps()));

    connect(this, SIGNAL(contentTypeChanged(TextContentType)), this, SLOT(setContentType(TextContentType)));
    connect(this, SIGNAL(activeLanguageChanged(QString)), this, SLOT(onLanguageChanged(QString)));
    connect(this, SIGNAL(languagePluginChanged(QString, QString)), d->editor.wordEngine(), SLOT(onLanguageChanged(QString, QString)));
    connect(&d->event_handler, SIGNAL(qmlCandidateChanged(QStringList)), d->editor.wordEngine(), SLOT(updateQmlCandidates(QStringList)));
    connect(this, SIGNAL(hasSelectionChanged(bool)), &d->editor, SLOT(onHasSelectionChanged(bool)));
    connect(d->editor.wordEngine(), SIGNAL(pluginChanged()), this, SLOT(onWordEnginePluginChanged()));
    connect(this, SIGNAL(keyboardStateChanged(QString)), &d->editor, SLOT(onKeyboardStateChanged(QString)));
    connect(d->m_geometry, SIGNAL(visibleRectChanged()), this, SLOT(onVisibleRectChanged()));
    connect(&d->m_settings, SIGNAL(disableHeightChanged(bool)), this, SLOT(onVisibleRectChanged()));

    connect(&d->editor, SIGNAL(preeditChanged(QString)), this, SIGNAL(preeditChanged(QString)));
    connect(&d->editor, SIGNAL(cursorPositionChanged(int)), this, SIGNAL(cursorPositionChanged(int)));

    d->registerAudioFeedbackSoundSetting();
    d->registerAudioFeedbackSetting();
    d->registerHapticFeedbackSetting();
    d->registerAutoCorrectSetting();
    d->registerAutoCapsSetting();
    d->registerWordEngineSetting();
    d->registerActiveLanguage();
    d->registerPreviousLanguage();
    d->registerEnabledLanguages();
    d->registerDoubleSpaceFullStop();
    d->registerStayHidden();
    d->registerPluginPaths();

    //fire signal so all listeners know what active language is
    Q_EMIT activeLanguageChanged(d->activeLanguage);

    // Setting layout orientation depends on word engine and hide word ribbon
    // settings to be initialized first:
    d->setLayoutOrientation(d->appsCurrentOrientation);

    QString prefix = qgetenv("KEYBOARD_PREFIX_PATH");
    if (!prefix.isEmpty()) {
        d->view->setSource(QUrl::fromLocalFile(prefix + QDir::separator() + g_maliit_keyboard_qml));
    } else {
        d->view->setSource(QUrl::fromLocalFile(g_maliit_keyboard_qml));
    }
    d->view->setGeometry(qGuiApp->primaryScreen()->geometry());
}

InputMethod::~InputMethod()
{}

void InputMethod::show()
{
    Q_D(InputMethod);

    if(!d->m_settings.stayHidden()) {
        d->m_geometry->setShown(true);
        update();
        d->view->setVisible(true);
    }
}

//! \brief InputMethod::hide
//! Begins the hiding animation within QML
void InputMethod::hide()
{
    Q_D(InputMethod);
    d->m_geometry->setShown(false);
}

//! \brief InputMethod::close
//! Closes the keyboard instantly (typically only called by QML after the
//! hiding animation has finished, under normal circumstances hide() should
//! be used instead)
void InputMethod::close()
{
    Q_D(InputMethod);
    d->closeOskWindow();
}

void InputMethod::reset()
{
    //this gets called from Qt when the focused editor changes
    //we need to clear preedit/word candidates in this case
    qDebug() << "inputMethod::reset()";
    Q_D(InputMethod);
    d->editor.clearPreedit();
    d->previous_position = -1;
    Q_EMIT keyboardReset();
}

void InputMethod::setPreedit(const QString &preedit,
                             int cursor_position)
{
    Q_UNUSED(cursor_position)
    Q_D(InputMethod);
    d->editor.replacePreedit(preedit);
}

void InputMethod::switchContext(Maliit::SwitchDirection direction,
                                bool animated)
{
    Q_UNUSED(direction)
    Q_UNUSED(animated)
}

QList<MAbstractInputMethod::MInputMethodSubView>
InputMethod::subViews(Maliit::HandlerState state) const
{
    Q_UNUSED(state)
    QList<MInputMethodSubView> views;
    return views;
}

// called by settings change/language change
void InputMethod::setActiveSubView(const QString &id,
                                   Maliit::HandlerState state)
{
    Q_UNUSED(state)
    Q_UNUSED(id);
}

QString InputMethod::activeSubView(Maliit::HandlerState state) const
{
    Q_UNUSED(state)
    Q_D(const InputMethod);

    return d->activeLanguage;
}

void InputMethod::handleFocusChange(bool focusIn)
{
    if (!focusIn) {
        hide();
    }
}

void InputMethod::handleAppOrientationChanged(int angle)
{
    Q_D(InputMethod);

    d->appsCurrentOrientation = rotationAngleToScreenOrientation(angle);
    d->setLayoutOrientation(d->appsCurrentOrientation);
}

void InputMethod::handleClientChange()
{
    // Clients connect to Maliit on startup and disconnect at quit. This method is called
    // for both those events. It makes sense to hide the keyboard always on these events,
    // especially if the client crashes, so that the OSK is closed. Fixes bug lp:1267550
    // Note that clients request OSK to appear & disappear with focus events.
    hide();
}

bool InputMethod::imExtensionEvent(MImExtensionEvent *event)
{
    if (not event or event->type() != MImExtensionEvent::Update) {
        return false;
    }
    return true;
}

void InputMethod::onAutoCorrectSettingChanged()
{
    Q_D(InputMethod);
    d->editor.setAutoCorrectEnabled(d->m_settings.autoCompletion());
}

void InputMethod::onDoubleSpaceSettingChanged()
{
    Q_D(InputMethod);
    d->editor.setDoubleSpaceFullStopEnabled(d->m_settings.doubleSpaceFullStop());
}

/*!
 * \brief InputMethod::updateAutoCaps enabled the use of auto capitalization
 * when the setting iss eto true, and the text area does not prevent to use it
 */
void InputMethod::updateAutoCaps()
{
    Q_D(InputMethod);
    bool enabled = d->m_settings.autoCapitalization();
    enabled &= d->contentType == FreeTextContentType;
    bool valid = true;
    bool autocap = d->host->autoCapitalizationEnabled(valid) && d->editor.wordEngine()->languageFeature()->autoCapsAvailable();
    enabled &= autocap;

    if (enabled != d->autocapsEnabled) {
        d->autocapsEnabled = enabled;
        d->editor.setAutoCapsEnabled(enabled);
        if (!enabled) {
            Q_EMIT deactivateAutocaps();
        }
    }
}

//! \brief InputMethod::onEnabledLanguageSettingsChanged
//! Updates the list of languages that can be used
void InputMethod::onEnabledLanguageSettingsChanged()
{
    Q_D(InputMethod);
    d->enabledLanguages = d->m_settings.enabledLanguages();
    if (!d->enabledLanguages.contains(d->previousLanguage)) {
        setPreviousLanguage("");
    }
    Q_EMIT enabledLanguagesChanged(d->enabledLanguages);
}

void InputMethod::setKeyOverrides(const QMap<QString, QSharedPointer<MKeyOverride> > &overrides)
{
    Q_D(InputMethod);

    // we only care about actionKey override by now
    const QMap<QString, SharedOverride >::const_iterator iter(overrides.find(actionKeyName));
    bool actionKeyChanged = false;

    if (d->actionKeyOverrider) {
        disconnect(d->actionKeyOverrider.data(), SIGNAL(keyAttributesChanged(const QString &, const MKeyOverride::KeyOverrideAttributes)),
                   this, SIGNAL(actionKeyOverrideChanged()));
        d->actionKeyOverrider.clear();
        actionKeyChanged = true;
    }

    if (iter != overrides.end()) {
        QSharedPointer<MKeyOverride> actionKeyOverrider(*iter);

        if (actionKeyOverrider) {
            d->actionKeyOverrider = actionKeyOverrider;
            connect(d->actionKeyOverrider.data(), SIGNAL(keyAttributesChanged(const QString &, const MKeyOverride::KeyOverrideAttributes)),
                    this, SIGNAL(actionKeyOverrideChanged()));
        }
        actionKeyChanged = true;
    }

    if (actionKeyChanged) {
        Q_EMIT actionKeyOverrideChanged();
    }
}

void InputMethod::onKeyboardClosed()
{
    hide();
    inputMethodHost()->notifyImInitiatedHiding();
}

void InputMethod::onLayoutWidthChanged(int width)
{
    Q_UNUSED(width);
}

void InputMethod::onLayoutHeightChanged(int height)
{
    Q_UNUSED(height);
}

void InputMethod::deviceOrientationChanged(Qt::ScreenOrientation orientation)
{
    Q_UNUSED(orientation);
    Q_D(InputMethod);

    d->setLayoutOrientation(d->appsCurrentOrientation);
}

void InputMethod::update()
{
    Q_D(InputMethod);

    if (!d->m_geometry->shown()) {
        // Don't update if we're in the process of hiding
        return;
    }

    bool valid;

    bool hasSelection = d->host->hasSelection(valid);

    if (valid && hasSelection != d->hasSelection) {
        d->hasSelection = hasSelection;
        Q_EMIT hasSelectionChanged(d->hasSelection);
    }

    bool emitPredictionEnabled = false;

    bool newPredictionEnabled = inputMethodHost()->predictionEnabled(valid)
                                || d->editor.wordEngine()->languageFeature()->alwaysShowSuggestions();

    if (!valid)
        newPredictionEnabled = true;

    if (d->wordEngineEnabled != newPredictionEnabled) {
        d->wordEngineEnabled = newPredictionEnabled;
        emitPredictionEnabled = true;
    }

    TextContentType newContentType = static_cast<TextContentType>( inputMethodHost()->contentType(valid) );
    if (!valid) {
        newContentType = FreeTextContentType;
    }
    setContentType(newContentType);

    if (emitPredictionEnabled) {
        updateWordEngine();
    }

    updateAutoCaps();

    QString text;
    int position;
    bool ok = d->host->surroundingText(text, position);
    if (ok) {
        d->editor.text()->setSurrounding(text);
        d->editor.text()->setSurroundingOffset(position);

        checkAutocaps();
        d->previous_position = position;
    }
}

void InputMethod::updateWordEngine()
{
    Q_D(InputMethod);

    if (d->contentType != FreeTextContentType
        && !(d->editor.wordEngine()->languageFeature()->alwaysShowSuggestions()
             && (d->contentType == UrlContentType || d->contentType == EmailContentType))) {
        d->wordEngineEnabled = false;
    }

    d->editor.clearPreedit();
    d->editor.wordEngine()->setEnabled( d->wordEngineEnabled );
}

//! \brief InputMethod::contentType returns the type, of the input field, like free text, email, url
//! \return
InputMethod::TextContentType InputMethod::contentType()
{
    Q_D(InputMethod);
    return d->contentType;
}

//! \brief InputMethod::setContentType sets the type, of the input field, like free text, email, url
//! \param contentType
void InputMethod::setContentType(TextContentType contentType)
{
    Q_D(InputMethod);

    if (contentType == d->contentType)
        return;

    setActiveLanguage(d->activeLanguage);

    d->editor.wordEngine()->languageFeature()->setContentType(static_cast<Maliit::TextContentType>(contentType));

    d->contentType = contentType;
    Q_EMIT contentTypeChanged(contentType);

    updateWordEngine();
    updateAutoCaps();
}

//! \brief InputMethod::checkAutocaps  Checks if the keyboard should be
//! set to uppercase after the cursor position has been changed.
void InputMethod::checkAutocaps()
{
    Q_D(InputMethod);

    if (d->autocapsEnabled) {
        QString text;
        int position;
        bool ok = d->host->surroundingText(text, position);
        QString textOnLeft = d->editor.text()->surroundingLeft() + d->editor.text()->preedit();
        if (textOnLeft.contains("\n")) {
            textOnLeft = textOnLeft.split("\n").last();
        }
        QStringList leftHandWords = textOnLeft.split(" ");
        bool email_detected = false;
        if (!leftHandWords.isEmpty() && leftHandWords.last().contains("@")) {
            email_detected = true;
        }
        if (ok && !email_detected && ((textOnLeft.isEmpty() && d->editor.text()->preedit().isEmpty())
                || d->editor.wordEngine()->languageFeature()->activateAutoCaps(textOnLeft)
                || d->editor.wordEngine()->languageFeature()->activateAutoCaps(textOnLeft.trimmed()))) {
            Q_EMIT activateAutocaps();
        } else {
            Q_EMIT deactivateAutocaps();
        }
    }
}

//! \brief InputMethod::enabledLanguages list of all languages that can be selected
const QStringList &InputMethod::enabledLanguages() const
{
    Q_D(const InputMethod);
    return d->enabledLanguages;
}

//! \brief InputMethod::activeLanguage returns the language that is currently
//! used by the keyboard
const QString &InputMethod::activeLanguage() const
{
    Q_D(const InputMethod);
    return d->activeLanguage;
}

//! \brief InputMethod::previousLanguage returns the language that was used
//! immediately prior to the current activeLanguage
const QString &InputMethod::previousLanguage() const
{
    Q_D(const InputMethod);
    return d->previousLanguage;
}

//! \brief InputMethod::useAudioFeedback is true, when keys should play a audio
//! feedback when pressed
//! \return
bool InputMethod::useAudioFeedback() const
{
    Q_D(const InputMethod);
    return d->m_settings.keyPressAudioFeedback();
}

//! \brief InputMethod::useHapticFeedback is true, when keys should produce haptic
//! feedback when pressed
//! \return
bool InputMethod::useHapticFeedback() const
{
    Q_D(const InputMethod);
    return d->m_settings.keyPressHapticFeedback();
}

//! \brief InputMethod::actionKeyOverride returns any override information about
//! the action key
//! \return
QObject *InputMethod::actionKeyOverride() const
{
    Q_D(const InputMethod);
    return d->actionKeyOverrider.data();
}

//! \brief InputMethod::audioFeedbackSound returns the current path to the audio
//! feedback sound
//! \return path to the feedback sound
const QString InputMethod::audioFeedbackSound() const
{
    Q_D(const InputMethod);
    return d->m_settings.keyPressAudioFeedbackSound();
}

//! \brief InputMethod::setActiveLanguage
//! Sets the currently active/used language
//! \param newLanguage id of the new language. For example "en" or "es"
//! FIXME check if the language is supported - if not use "en" as fallback
void InputMethod::setActiveLanguage(const QString &newLanguage)
{
    Q_D(InputMethod);

    qDebug() << "in inputMethod.cpp setActiveLanguage() activeLanguage is:" << newLanguage;

    foreach(QString pluginPath, d->pluginPaths) {
        QDir testDir(pluginPath + QDir::separator() + newLanguage);
        if (testDir.exists()) {
            d->currentPluginPath = testDir.absolutePath();
            break;
        }
    }

    if (d->activeLanguage == newLanguage)
        return;

    d->editor.commitPreedit();

    setPreviousLanguage(d->activeLanguage);
    d->activeLanguage = newLanguage;
    d->host->setLanguage(newLanguage);
    d->m_settings.setActiveLanguage(newLanguage);

    qDebug() << "in inputMethod.cpp setActiveLanguage() emitting activeLanguageChanged to" << d->activeLanguage;
    Q_EMIT activeLanguageChanged(d->activeLanguage);
}

//! \brief InputMethod::setPreviousLanguage
//! Set the language used immediately prior to the current active language.
//! \param prevLanguage id the previous language used. e.g. "en" or "emoji"
void InputMethod::setPreviousLanguage(const QString &prevLanguage)
{
    Q_D(InputMethod);

    if (d->previousLanguage == prevLanguage)
        return;

    d->previousLanguage = prevLanguage;
    d->m_settings.setPreviousLanguage(prevLanguage);

    Q_EMIT previousLanguageChanged(d->previousLanguage);
}


void InputMethod::onWordEnginePluginChanged()
{
    reset();
    update();
}

const QString InputMethod::keyboardState() const
{
    Q_D(const InputMethod);
    return d->keyboardState;
}

void InputMethod::setKeyboardState(const QString &state)
{
    Q_D(InputMethod);
    d->keyboardState = state;
    Q_EMIT keyboardStateChanged(d->keyboardState);
}

bool InputMethod::hasSelection() const
{
    Q_D(const InputMethod);
    return d->hasSelection;
}

void InputMethod::onVisibleRectChanged()
{
    Q_D(InputMethod);

    QRect visibleRect = d->m_geometry->visibleRect().toRect();

    if (d->m_settings.disableHeight() && QGuiApplication::platformName() == "ubuntumirclient") {
        visibleRect.setHeight(0);
    }

    inputMethodHost()->setScreenRegion(QRegion(visibleRect));
    inputMethodHost()->setInputMethodArea(visibleRect, d->view);

    qDebug() << "keyboard is reporting <x y w h>: <"
                << visibleRect.x()
                << visibleRect.y()
                << visibleRect.width()
                << visibleRect.height()
                << "> to the app manager.";

}

const QString InputMethod::currentPluginPath() const
{
    Q_D(const InputMethod);
    return d->currentPluginPath;
}

const QString &InputMethod::preedit()
{
    Q_D(InputMethod);
    d->preedit = d->editor.text()->preedit();
    return d->preedit;
}

int InputMethod::cursorPosition() const
{
    Q_D(const InputMethod);
    return d->editor.text()->cursorPosition();
}

void InputMethod::replacePreedit(const QString &preedit)
{
    Q_D(InputMethod);
    d->editor.replacePreedit(preedit);
}

void InputMethod::setCursorPosition(const int pos)
{
    Q_D(InputMethod);
    d->editor.setCursorPosition(pos);
}

QString InputMethod::surroundingLeft()
{
    Q_D(InputMethod);
    return d->editor.text()->surroundingLeft();
}

QString InputMethod::surroundingRight()
{
    Q_D(InputMethod);
    return d->editor.text()->surroundingRight();
}

bool InputMethod::languageIsSupported(const QString plugin) {
    Q_D(const InputMethod);
    foreach(QString pluginPath, d->pluginPaths) {
        QDir testDir(pluginPath + QDir::separator() + plugin);
        if (testDir.exists()) {
            return true;
        }
    }

    return false;
}

void InputMethod::onLanguageChanged(const QString &language) {
    Q_D(InputMethod);
    foreach(QString pluginPath, d->pluginPaths) {
        QFile testFile(pluginPath + QDir::separator() + language + QDir::separator() + "lib" + language + "plugin.so");
        if (testFile.exists()) {
            Q_EMIT languagePluginChanged(testFile.fileName(), language);
            return;
        }
    }
    qCritical() << "Couldn't find word engine plugin for " << language;
}

void InputMethod::onPluginPathsChanged(const QStringList& pluginPaths) {
    Q_D(InputMethod);
    Q_UNUSED(pluginPaths);

    d->updatePluginPaths();
}

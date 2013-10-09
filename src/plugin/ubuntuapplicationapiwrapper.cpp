/*
 * Copyright 2013 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "ubuntuapplicationapiwrapper.h"

// FIXME: this is hacky way of deciding if running on Touch platform or not
#include <QtCore/qconfig.h>

#ifdef QT_OPENGL_ES_2
#include <ubuntu/ui/ubuntu_ui_session_service.h>
#include <ubuntu/application/ui/window_properties.h>
  #define HAVE_UBUNTU_PLATFORM_API
#endif

#include <QtGlobal>
#include <QByteArray>

namespace {
    const char gServerName[] = "ubuntu-keyboard-info";
}

UbuntuApplicationApiWrapper::UbuntuApplicationApiWrapper()
    : m_runningOnMir(false),
      m_clientConnection(0)
{
    if (qgetenv("QT_QPA_PLATFORM") == "ubuntumirclient") {
        m_runningOnMir = true;
    }

    if (m_runningOnMir) {
        connect(&m_localServer, &QLocalServer::newConnection,
                this, &UbuntuApplicationApiWrapper::onNewConnection);
        bool ok = m_localServer.listen(gServerName);
        if (!ok) {
            qWarning() << "UbuntuApplicationApiWrapper: failed to listen for connections on"
                       << gServerName;
        }
    }
}

void UbuntuApplicationApiWrapper::reportOSKVisible(const int x, const int y, const int width, const int height)
{
#ifdef HAVE_UBUNTU_PLATFORM_API
    if (!m_runningOnMir) { // following method not implemented on Mir
        ubuntu_ui_report_osk_visible(x, y, width, height);
    }
#else
    Q_UNUSED(x)
    Q_UNUSED(y)
    Q_UNUSED(width)
    Q_UNUSED(height)
#endif

    sendInfoToClientConnection(width, height);
}

void UbuntuApplicationApiWrapper::reportOSKInvisible()
{
#ifdef HAVE_UBUNTU_PLATFORM_API
    if (!m_runningOnMir) { // following method not implemented on Mir
        ubuntu_ui_report_osk_invisible();
    }
#endif
}

int UbuntuApplicationApiWrapper::oskWindowRole() const
{
#ifdef HAVE_UBUNTU_PLATFORM_API
    return static_cast<int>(U_ON_SCREEN_KEYBOARD_ROLE);
#else
    return 7;
#endif
}

void UbuntuApplicationApiWrapper::sendInfoToClientConnection(int width, int height)
{
    if (!m_clientConnection
            || m_clientConnection->state() != QLocalSocket::ConnectedState) {
        // can't do it
        return;
    }

    struct SharedInfo sharedInfo;
    sharedInfo.keyboardWidth = width;
    sharedInfo.keyboardHeight = height;
    const qint64 sharedInfoSize = sizeof(struct SharedInfo);
    qint64 bytesWritten = m_clientConnection->write(reinterpret_cast<char *>(&sharedInfo),
                                                    sharedInfoSize);

    if (bytesWritten < 0) {
        qWarning("UbuntuApplicationApiWrapper: Failed to write bytes on client connection");
    } else if (bytesWritten != sharedInfoSize) {
        // Could try sending the remaining bytes until completion but it's really unlikely that
        // this situation will occur
        qWarning() << "UbuntuApplicationApiWrapper: tried to write" << sharedInfoSize << "bytes"
                      "but only" << bytesWritten << "went through";
    }
}

void UbuntuApplicationApiWrapper::onNewConnection()
{
    if (m_clientConnection)
        return; // ignore it. for simplicity we care to serve only one client (unity8-mir)

    m_clientConnection = m_localServer.nextPendingConnection();
    connect(m_clientConnection, &QLocalSocket::disconnected,
            this, &UbuntuApplicationApiWrapper::onClientDisconnected);

    typedef void (QLocalSocket::*MemberFunctionType)(QLocalSocket::LocalSocketError);
    MemberFunctionType funcPointer = &QLocalSocket::error;
    connect(m_clientConnection, funcPointer,
            this, &UbuntuApplicationApiWrapper::onClientError);
}

void UbuntuApplicationApiWrapper::onClientDisconnected()
{
    delete m_clientConnection;
    m_clientConnection = 0;
}

void UbuntuApplicationApiWrapper::onClientError(QLocalSocket::LocalSocketError socketError)
{
    Q_UNUSED(socketError);
    delete m_clientConnection;
    m_clientConnection = 0;
}

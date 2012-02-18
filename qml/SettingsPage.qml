import QtQuick 1.1
import "meego"
import com.pipacs.ionic.Bookmark 1.0
import com.pipacs.ionic.Book 1.0

StepsPage {
    orientationLock: prefs.orientation
    id: page

    Flickable {
        id: flickable
        anchors.fill: parent
        anchors.margins: 5
        anchors.topMargin: 15
        anchors.leftMargin: 15
        contentWidth: column.width
        contentHeight: column.height
        flickableDirection: Flickable.VerticalFlick
        clip: true

        Column {
            id: column
            spacing: 30

            StepsCheckBox {
                id: useVolumeKeys
                text: "Navigate with volume keys"
                checked: prefs.useVolumeKeys
                onClicked: prefs.useVolumeKeys = checked
            }
            StepsCheckBox {
                id: useSwipe
                text: "Navigate with swipe"
                checked: prefs.useSwipe
                // enabled: useVolumeKeys.checked
                onClicked: prefs.useSwipe = checked
            }
            StepsCheckBox {
                id: showToolbar
                text: "Show toolbar"
                checked: prefs.showToolBar
                onClicked: prefs.showToolBar = checked
            }
            StepsLabel {
                width: parent.width
                color: "grey"
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: "If the toolbar is hidden, double-tap to reveal it temporarily"
            }
            StepsLabel {
                text: "Zoom level:"
            }
            StepsSlider {
                id: zoom
                property bool firstUpdate: true
                stepSize: 10
                valueIndicatorVisible: true
                minimumValue: 80
                maximumValue: 250
                value: prefs.zoom
                onChangedChanged: prefs.zoom = value
            }
            StepsLabel {
                text: "Theme:"
            }
            StepsButtonRow {
                StepsButton {
                    text: "Day"
                    checked: prefs.style == "day"
                    onClicked: {
                        prefs.style = "day"
                        mainPage.setStyle("day")
                    }
                }
                StepsButton {
                    text: "Night"
                    checked: prefs.style == "night"
                    onClicked: {
                        prefs.style = "night"
                        mainPage.setStyle("night")
                    }
                }
                StepsButton {
                    text: "Sand"
                    checked: prefs.style == "sand"
                    onClicked: {
                        prefs.style = "sand"
                        mainPage.setStyle("sand")
                    }
                }
            }
            StepsLabel {
                text: "Orientation:"
            }
            StepsButtonRow {
                StepsButton {
                    text: "Auto"
                    checked: prefs.orientation === page.orientationAutomatic
                    onClicked: prefs.orientation = page.orientationAutomatic
                }
                StepsButton {
                    text: "Portrait"
                    checked: prefs.orientation === page.orientationLockPortrait
                    onClicked: prefs.orientation = page.orientationLockPortrait
                }
                StepsButton {
                    text: "Landscape"
                    checked: prefs.orientation === page.orientationLockLandscape
                    onClicked: prefs.orientation = page.orientationLockLandscape
                }
            }
            StepsCheckBox {
                id: preventBlanking
                text: "Prevent display blanking"
                checked: prefs.preventBlanking
                onClicked: prefs.preventBlanking = checked
            }
            StepsLabel {
                text: "Brightness:"
            }
            StepsSlider {
                id: brightness
                property bool firstUpdate: true
                stepSize: 1
                valueIndicatorVisible: true
                minimumValue: 1
                maximumValue: 5
                value: platform.brightness
                onChangedChanged: platform.brightness = value
            }
        }
    }

    StepsScrollDecorator {
        flickableItem: flickable
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            if (prefs.preventBlanking) {
                platform.pauseBlanking()
            }
        }
    }

    Component.onCompleted: {
        zoom.value = prefs.zoom
    }

    onBack: pageStack.pop()
}
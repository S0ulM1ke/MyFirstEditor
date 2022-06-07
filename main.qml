import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3
import ImageSaver 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Item {
        id: root
        width: parent.width
        height: parent.height - (layout.height / 2)

            Image {
                id: rootImage
                visible: false
                source: "wallpaper.jpg"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }

            HueSaturation {
                id: primaryProcessing
                anchors.fill: parent
                source: rootImage
                visible: false
                Component.onCompleted: {
                    hue = Qt.binding(function() {return repeater.itemAt(0).value / 100})
                    saturation = Qt.binding(function() {return repeater.itemAt(1).value / 100})
                    lightness = Qt.binding(function() {return repeater.itemAt(2).value / 100})
                }
            }

            FastBlur {
                id: secondaryProcessing
                source: primaryProcessing
                anchors.fill: rootImage
                radius: (raiusDial.radiusValue * 64) / 100
                visible: true
            }
    }

    RowLayout {
        //Probably should put it on another file
        //Some dependances is incorrect
        id: layout
        property int dialWidth: 85

        anchors {
              horizontalCenter: parent.horizontalCenter
              bottom: parent.bottom
              margins: -50
          }
//        height: children.height
//        width: children.width
        spacing: 20


        Repeater {
            id: repeater
            model: 3

            Dial {
               property int m_value: value
                implicitWidth: layout.dialWidth
                from: -100
                to: 100


                Text {
                    id: valueText
                    property string valueType: "Fail"
                    Component.onCompleted: {
                        switch (index) {
                            case 0:
                                valueType = "Hue"
                                break
                            case 1:
                                valueType = "Saturation"
                                break
                            case 2:
                                valueType = "Ligthtness"
                                break
                            default:
                                break
                        }
                    }
                    text: valueType + ":\n" + parent.m_value + "%"
                    font.pointSize: 7
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
            }
        }

        Dial {
            id: raiusDial
            property int radiusValue: value
            implicitWidth: layout.dialWidth
            to: 100
            Text{

                text: "Blur:\n" + parent.radiusValue + "%"
                font.pointSize: 7
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
            }
        }
    }

    ColumnLayout {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 5

        Button {
            text: "Upload file"
            onClicked: openDialog.open()
        }

        Button {
            text: "Save result"
            onClicked: saveDialog.open()
        }
    }

    ImageSaver {
        id: saveImageOnUrl
    }

    FileDialog {
        //Upload Image
        id: openDialog
        nameFilters: ["Image files (*.png *.jpg)"]
        folder: shortcuts.pictures
        onAccepted: {
            rootImage.source = fileUrl
        }
    }

    FileDialog {
        //Save image on cpp function
        id: saveDialog
        folder: shortcuts.pictures
        selectExisting: false
        defaultSuffix: "untitled" //thats dosen't even work
        nameFilters: [ "JPG (*.jpg)", "PNG (*.png)" ]
        onAccepted: {
            secondaryProcessing.grabToImage(function(result){
            saveImageOnUrl.saveImage(result.image, fileUrl);
            })


        }
    }
}









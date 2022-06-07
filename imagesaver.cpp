#include "imagesaver.h"
#include "qdebug.h"
#include "qurl.h"
#include <QImage>

ImageSaver::ImageSaver(QObject *parent)
    : QObject{parent}
{

}

void ImageSaver::saveImage(QVariant var, QUrl url)
{
        QImage img = qvariant_cast<QImage>(var);
        QString saveUrl = url.path();

        saveUrl.remove(0, 1);
        img.save(saveUrl);
}

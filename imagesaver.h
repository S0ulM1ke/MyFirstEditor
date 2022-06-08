#ifndef IMAGESAVER_H
#define IMAGESAVER_H

#include <QObject>
#include <QVariant>
#include <QUrl>

class ImageSaver : public QObject
{
    Q_OBJECT
public:
    explicit ImageSaver(QObject *parent = nullptr);

    Q_INVOKABLE void saveImage(QVariant var, QUrl url);
};

#endif // IMAGESAVER_H

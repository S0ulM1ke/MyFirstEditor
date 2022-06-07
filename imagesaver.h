#ifndef IMAGESAVER_H
#define IMAGESAVER_H

#include <QObject>

class ImageSaver : public QObject
{
    Q_OBJECT
public:
    explicit ImageSaver(QObject *parent = nullptr);

    Q_INVOKABLE void saveImage(QVariant var, QUrl url);


signals:

};

#endif // IMAGESAVER_H

### Android development environment for ubuntu 14.04 LTS

* Oracle Java JDK 7
* Android SDK r23.0.2
* Gradle 2.0

#### Install

You can either pull from `vmlinz/docker-android-dev`:

```
docker pull vmlinz/docker-android-dev
```

```
docker run -i -t vmlinz/docker-android-dev /bin/bash
```

or add it to your Dockerfile:

```
FROM vmlinz/docker-android-dev
```


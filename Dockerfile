FROM ubuntu:18.04

# Установка зависимостей
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc g++ \
    wget \
    make \
    && rm -rf /var/lib/apt/lists/*

# Установка CMake 3.11+
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' && \
    apt-get update && \
    apt-get install -y --no-install-recommends cmake

# Копирование исходников
COPY . print/
WORKDIR print

# Сборка проекта
RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install && \
    cmake --build _build && \
    cmake --build _build --target install

# Настройка окружения
ENV LOG_PATH=/home/logs/log.txt
VOLUME /home/logs
WORKDIR _install/bin
ENTRYPOINT ["./demo"]
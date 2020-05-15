FROM alpine
MAINTAINER Daniel Haber

# Install emby
RUN export LANG=C.UTF-8 && \
    ff_url='http://johnvansickle.com/ffmpeg/releases' && \
    glib_url='https://github.com/sgerrand/alpine-pkg-glibc/releases/download'&&\
    glib_version=2.31-r0 && \
    glibc_base=glibc-${glib_version}.apk && \
    glibc_bin=glibc-bin-${glib_version}.apk && \
    glibc_i18n=glibc-i18n-${glib_version}.apk && \
    monourl='https://archive.archlinux.org/packages/m/mono' && \
    mono_version=6.4.0.198-1 && \
    key=/etc/apk/keys/sgerrand.rsa.pub && \
    url='https://github.com/MediaBrowser/Emby.Releases/releases/download' && \
    version=4.4.2.0 && \
    apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add bash curl shadow sqlite-libs tini tzdata&&\
    curl -LSs https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o $key && \
    curl -LOSs $glib_url/$glib_version/$glibc_base && \
    curl -LOSs $glib_url/$glib_version/$glibc_bin && \
    curl -LOSs $glib_url/$glib_version/$glibc_i18n && \
    apk --no-cache --no-progress add $glibc_base $glibc_bin $glibc_i18n && \
    { /usr/glibc-compat/bin/localedef -c -iPOSIX -fUTF-8 $LANG || :; } && \
    ln -s libsqlite3.so.0 /usr/lib/libsqlite3.so && \
    curl -LSs $monourl/mono-${mono_version}-x86_64.pkg.tar.xz -o mono.txz && \
    tar xf mono.txz && \
    addgroup -S emby && \
    adduser -S -D -H -h /usr/lib/emby-server -s /sbin/nologin -G emby \
                -g 'Emby User' emby && \
    echo "Downloading version: $version" && \
    curl -LSs $url/$version/embyserver-netframework_$version.zip -o emby.zip &&\
    curl -LSs "$ff_url/ffmpeg-release-amd64-static.tar.xz" -o ffmpeg.txz && \
    { tar --strip-components=1 -C /bin -xf ffmpeg.txz "*/ffmpeg" 2>&-||:; } && \
    { tar --strip-components=1 -C /bin -xf ffmpeg.txz "*/ffprobe" 2>&-||:; } &&\
    mkdir -p /share/.config/emby /usr/lib/emby-server && \
    unzip emby.zip -d /usr/lib/emby-server && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    chown -Rh root. /bin/ff* /usr/lib/emby-server && \
    chown -Rh emby. /share/.config/emby && \
    apk del glibc-i18n && \
    rm -rf /tmp/* /var/cache/* emby.zip ffmpeg.txz glibc* $key mono.txz

COPY run.sh /usr/bin/

EXPOSE 8096 8920 7359/udp 1900/udp

HEALTHCHECK --interval=60s --timeout=15s --start-period=90s \
            CMD curl -L http://localhost:8096/

VOLUME ["/share"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/run.sh"]

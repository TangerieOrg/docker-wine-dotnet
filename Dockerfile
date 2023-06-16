ARG WINE_BRANCH "staging"
FROM docker.tangerie.xyz/docker-wine-staging:latest

ARG WINE_ARCH "win32"

ENV WINEDEBUG "fixme-all"

ENV RUN_AS_ROOT "yes"
ENV USE_XVFB "yes"
ENV XVFB_SERVER ":95"
ENV XVFB_SCREEN "0"
ENV XVFB_RESOLUTION "1024x768x8"
ENV DISPLAY ":95"
ENV WINEARCH $WINE_ARCH

RUN export DISPLAY=:0 \
   && (Xvfb $DISPLAY -screen 0 1024x768x24 > /dev/null 2>&1 &) \
   && wine wineboot --init \
   && winetricks --unattended --force -q dotnet20 dotnet462 dotnet_verifier \
   && while pgrep wineserver >/dev/null; do echo "Waiting for wineserver"; sleep 1; done \
   && rm -rf $HOME/.cache/winetricks

# RUN set -x -e; \
#     entrypoint wineboot --init; \
#     while true; do \
#       if timeout 30m winetricks --unattended --force cmd dotnet20 dotnet472 corefonts; then \
#         break; \
#       fi \
#     done; \
#     while pgrep wineserver >/dev/null; do echo "Waiting for wineserver"; sleep 1; done; \
#     rm -rf $HOME/.cache/winetricks;
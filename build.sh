docker build --push --build-arg WINE_BRANCH=staging --build-arg WINE_ARCH=win64 -t docker.tangerie.xyz/docker-wine-dotnet-64:latest .
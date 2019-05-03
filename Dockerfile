FROM microsoft/dotnet:2.2-aspnetcore-runtime

LABEL maintainer="petar.gjeorgiev@interworks.com.mk"

WORKDIR /app
COPY ./publish ./

ENTRYPOINT ["dotnet", "IW.Kubernetes.POC.dll"]
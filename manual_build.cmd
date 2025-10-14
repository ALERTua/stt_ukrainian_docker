
@echo off
setlocal enabledelayedexpansion enableextensions

if not defined DOCKER_HOSTNAME set DOCKER_HOSTNAME=docker
if not defined DOCKER_HOST set DOCKER_HOST=tcp://%DOCKER_HOSTNAME%:2375
if not defined STAGE set STAGE=production
if not defined DOCKERFILE set DOCKERFILE=Dockerfile
if not defined TAG set TAG=latest

set TAG_GH=ghcr.io/alertua/stt_ukrainian_docker:%TAG%
set TAG_DOCKERHUB=alertua/stt_ukrainian_docker:%TAG%
set TAG_LOCAL=registry.alrt.pp.ua/alertua/stt_ukrainian_docker:%TAG%


choice /C YN /d N /T 15 /m "Build %STAGE% %TAG%?"
if "%errorlevel%"=="1" (
    docker build -f %DOCKERFILE% --target %STAGE% -t %TAG_GH% -t %TAG_DOCKERHUB% -t %TAG_LOCAL% .
)

choice /C YN /m "Push %TAG_LOCAL%?"
if "%errorlevel%"=="1" (
    docker push %TAG_LOCAL%
)

choice /C YN /m "Push %TAG_DOCKERHUB%?"
if "%errorlevel%"=="1" (
    docker push %TAG_DOCKERHUB%
)

choice /C YN /m "Push %TAG_GH%?"
if "%errorlevel%"=="1" (
    docker push %TAG_GH%
)

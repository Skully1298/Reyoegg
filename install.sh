#!/bin/bash

function display {
    echo -e "\033c"
    echo "
    ==========================================================================
    

$(tput setaf 6)########  ######## ##    ##  #######  
$(tput setaf 6)##     ## ##        ##  ##  ##     ## 
$(tput setaf 6)##     ## ##         ####   ##     ## 
$(tput setaf 6)########  ######      ##    ##     ## 
$(tput setaf 6)##   ##   ##          ##    ##     ## 
$(tput setaf 6)##    ##  ##          ##    ##     ## 
$(tput setaf 6)##     ## ########    ##     #######   
$(tput setaf 6) Made by Skully with 💖

    ==========================================================================
    "  
}

forceStuffs() {
if [ "$HIBERNATE_STATUS" == "true" ]; then
mkdir -p plugins
curl -s -o plugins/hibernate.jar https://raw.githubusercontent.com/skully1298/reyoeggg/main/Hibernate-2.1.0.jar
fi
echo "eula=true" > eula.txt
}
  
  echo "motd=Powered by Reyo | Software Developed by Skully"


function launchJavaServer {
  java -Xms1024M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paper-server.jar nogui
}
FILE=eula.txt


function optimizeJavaServer {
  echo "view-distance=6" >> server.properties
  
} 

if [ ! -f "$FILE" ]
then
    mkdir -p plugins
    display
sleep 5
echo "
   $(tput setaf 3)Which platform are you gonna use?
  1) Paper             5) Velocity
  2) PocketmineMP      6) Node.js
  3) Purpur      
  4) BungeeCord
  "
read -r n

case $n in
  1) 
    sleep 1

    echo "$(tput setaf 3)Starting the download for PaperMC ${MINECRAFT_VERSION} please wait"
    rm proxy
    sleep 4

    forceStuffs
    

    VER_EXISTS=$(curl -s https://api.papermc.io/v2/projects/paper | jq -r --arg VERSION $MINECRAFT_VERSION '.versions[] | contains($VERSION)' | grep -m1 true)
	LATEST_VERSION=$(curl -s https://api.papermc.io/v2/projects/paper | jq -r '.versions' | jq -r '.[-1]')

	if [ "${VER_EXISTS}" == "true" ]; then
		echo -e "Version is valid. Using version ${MINECRAFT_VERSION}"
	else
		echo -e "Specified version not found. Defaulting to the latest paper version"
		MINECRAFT_VERSION=${LATEST_VERSION}
	fi
	
	BUILD_NUMBER=$(curl -s https://api.papermc.io/v2/projects/paper/versions/${MINECRAFT_VERSION} | jq -r '.builds' | jq -r '.[-1]')
	JAR_NAME=paper-${MINECRAFT_VERSION}-${BUILD_NUMBER}.jar
	DOWNLOAD_URL=https://api.papermc.io/v2/projects/paper/versions/${MINECRAFT_VERSION}/builds/${BUILD_NUMBER}/downloads/${JAR_NAME}
	curl -o server.jar "${DOWNLOAD_URL}"
touch paper
rm bungee
rm velocity
rm purpur
    display
    
    echo -e ""
    
    optimizeJavaServer
    launchJavaServer
    forceStuffs
  ;;
  3)
    sleep 1

    echo "$(tput setaf 3)Starting the download for PurpurMC ${MINECRAFT_VERSION} please wait"

    sleep 4

    forceStuffs
    
    
    VER_EXISTS=$(curl -s https://api.purpurmc.org/v2/purpur | jq -r --arg VERSION $MINECRAFT_VERSION '.versions[] | contains($VERSION)' | grep true)
	LATEST_VERSION=$(curl -s https://api.purpurmc.org/v2/purpur | jq -r '.versions' | jq -r '.[-1]')

	if [ "${VER_EXISTS}" == "true" ]; then
		echo -e "Version is valid. Using version ${MINECRAFT_VERSION}"
	else
		echo -e "Specified version not found. Defaulting to the latest purpur version"
		MINECRAFT_VERSION=${LATEST_VERSION}
	fi
	
	BUILD_NUMBER=$(curl -s https://api.purpurmc.org/v2/purpur/${MINECRAFT_VERSION} | jq -r '.builds.latest')
	JAR_NAME=purpur-${MINECRAFT_VERSION}-${BUILD_NUMBER}.jar
	DOWNLOAD_URL=https://api.purpurmc.org/v2/purpur/${MINECRAFT_VERSION}/${BUILD_NUMBER}/download
	
	curl -o server.jar "${DOWNLOAD_URL}"
touch purpur
rm paper
rm bungee
rm velocity
    display
    
    echo -e ""
    
    optimizeJavaServer
    launchJavaServer
    forceStuffs
  ;;
  4)
    sleep 1
    
    echo "$(tput setaf 3)Starting the download for Bungeecord latest please wait"
    
    sleep 4

    curl -o server.jar https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar
    
    touch bungee
    rm paper
    rm purpur
    rm velocity
    
    display
    
    sleep 10

    echo -e ""

    launchJavaServer bungee
  ;;
      5)
    sleep 1
    
    echo "$(tput setaf 3)Starting the download for Velocity please wait"
    
    sleep 4

if [[ -z ${VELOCITY_VERSION} ]] || [[ ${VELOCITY_VERSION} == "latest" ]]; then
    VELOCITY_VERSION="latest"
fi

    VER_EXISTS=$(curl -s https://papermc.io/api/v2/projects/velocity | jq -r --arg VERSION $VELOCITY_VERSION '.versions[] | contains($VERSION)' | grep true)
    LATEST_VERSION=$(curl -s https://papermc.io/api/v2/projects/velocity | jq -r '.versions' | jq -r '.[-1]')

if [[ "${VER_EXISTS}" == "true" ]]; then
    echo -e "Version is valid. Using version ${VELOCITY_VERSION}"
else
    echo -e "Using the latest velocity version"
    VELOCITY_VERSION=${LATEST_VERSION}
fi    
JAR_NAME=velocity-${VELOCITY_VERSION}-latest.jar
DOWNLOAD_URL=https://papermc.io/api/v2/projects/velocity/versions/${VELOCITY_VERSION}/builds/${BUILD_NUMBER}/downloads/${JAR_NAME}

curl -o server.jar ${DOWNLOAD_URL}

if [[ -f velocity.toml ]]; then
    echo -e "velocity config file exists"
else
    echo -e "downloading velocity config file."
    curl https://raw.githubusercontent.com/parkervcp/eggs/master/game_eggs/minecraft/proxy/java/velocity/velocity.toml -o velocity.toml
fi

if [[ -f forwarding.secret ]]; then
    echo -e "velocity forwarding secret file already exists"
else
    echo -e "creating forwarding secret file"
    touch forwarding.secret
    date +%s | sha256sum | base64 | head -c 12 > forwarding.secret
fi
    touch velocity
    rm paper
    rm purpur
    rm bungee
    display
    
    sleep 10

    echo -e ""

    launchJavaServer velocity
  ;;
  2)
  sleep 1
  
  echo "$(tput setaf 3)Starting the download for PocketMine-MP ${PMMP_VERSION} please wait"
  
  sleep 4
  
  PMMP_VERSION="${PMMP_VERSION^^}"
  
  if [[ "${PMMP_VERSION}" == "PM4" ]]; then
    API_CHANNEL="4"
  elif [[ "${PMMP_VERSION}" == "PM5" ]]; then
     API_CHANNEL="stable"
  else
    printf "Unsupported version: %s" "${PMMP_VERSION}"
    exit 1
  fi
  
  if [ ! "$(command -v ./bin/php7/bin/php)" ]; then
    installPhp "$API_CHANNEL" "$PMMP_VERSION"
    sleep 5
  fi
  
  
  DOWNLOAD_LINK=$(curl -sSL https://update.pmmp.io/api?channel="$API_CHANNEL" | jq -r '.download_url')

  curl --location --progress-bar "${DOWNLOAD_LINK}" --output PocketMine-MP.phar
  
  display
    
  echo -e ""
  
  launchPMMPServer
  ;;
  6)
  echo "$(tput setaf 3)Starting Download please wait"
  touch nodejs
  
  display
  
  sleep 10

  echo -e ""
  
  launchNodeServer
  ;;
  *) 
    echo "Error 404"
    exit
  ;;
esac  
else
if [ -e "server.jar" ]; then
    display   
    forceStuffs
    if [ -e "bungee" ]; then
    launchJavaServer bungee
    elif [ -e "velocity" ]; then
    launchJavaServer velocity
    elif [ -e "paper" ]; then
    launchJavaServer paper
    elif [ -e "purpur" ]; then
    launchJavaServer purpur
    fi
elif [ -e "PocketMine-MP.phar" ]; then
    display
    launchPMMPServer
elif [ -e "nodejs" ]; then
    display
    launchNodeServer
fi
    chmod +x ./install.sh
fi

source .env

# Menu for this script
print_usage() {
    echo "Usage: build.sh [-s ...] [-u ...] [-p ...] [-t ...]"
    echo "-s Server"
    echo "-u Username"
    echo "-p Password"
    echo "-t Tag"
    exit 0
}

# Handle user-specific variable overrides
while getopts ":s:u:p:t:" option "${@:2}"
do
    case ${option} in
        s) SERVER=${OPTARG};;
        u) USERNAME=${OPTARG};;
        p) PASSWORD=${OPTARG};;
        t) TAG=${OPTARG};;
        \?) print_usage;;
    esac
done

# Print everything
echo "Server:       $SERVER"
echo "Username:     $USERNAME"
echo "Password:     *********"
echo "Tag:          $TAG"
echo ""

read -p "Do you want build the main image ${TAG}? (Y/N): " buildVar
read -p "Do you want to download the main image ${TAG} from Azure? (Y/N): " downloadVar
read -p "Do you want to publish the main image ${TAG} to Azure? (Y/N): " publishVar

# Build from scratch
if [[ "$buildVar" = "Y" ]] || [[ "$buildVar" = "y" ]]; then
    echo "Building ${TAG}..."
    docker build -t $SERVER/$TAG -f  ../Dockerfile ..
fi

# Download from Azure
if [[ "$downloadVar" = "Y" ]] || [[ "$downloadVar" = "y" ]]; then
    echo "Downloading ${SERVER}/${TAG} from Azure..."
    docker login --username $USERNAME --password $PASSWORD $SERVER
    docker pull $SERVER/$TAG
fi

# Publish to Azure
if [[ "$publishVar" = "Y" ]] || [[ "$publishVar" = "y" ]]; then
    echo "Publishing ${SERVER}/${TAG} to Azure..."
    docker login --username $USERNAME --password $PASSWORD $SERVER
    docker push $SERVER/$TAG
fi

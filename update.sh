xcodebuild -version
#time carthage update --platform iOS --configuration Debug
time carthage update  --use-xcframeworks --platform iOS --configuration Debug --cache-builds $1
#!/bin/sh
assets="/var/assets"
nodejsRoot="/workspace/nodejs"
javaRoot="/workspace/java"
docsRoot="/workspace/docs/md"
versionPlaceholder="__VERSION__"

copyAssets() {
  cp $assets/package.json $nodejsRoot/package.json
  cp $assets/.npmrc $nodejsRoot/.npmrc
  cp $docsRoot/index.md $nodejsRoot/README.md
  cp $assets/pom.xml $javaRoot/pom.xml
  cp $assets/settings.xml $javaRoot/settings.xml
  cp $docsRoot/index.md $javaRoot/README.md
  if [[ "${local}" ]]; then
    cp -a $assets/mvn-wrapper/. $javaRoot/
  fi
}

setVersionNumber() {
  version=$(node -p -e "require('$assets/root-package.json').version")
  sed -i "s/$versionPlaceholder/$version/g" "$nodejsRoot/package.json"
  if [[ -z "${local}" ]]; then
    sed -i "s/$versionPlaceholder/$version/g" "$javaRoot/pom.xml"
  else
    sed -i "s/$versionPlaceholder/$version-SNAPSHOT/g" "$javaRoot/pom.xml"
  fi

}

publish() {
  cd $nodejsRoot && npm publish
  cd $javaRoot && mvn -B package deploy -s $javaRoot/settings.xml
}

copyAssets
setVersionNumber
if [[ -z "${local}" ]]; then
  publish
fi

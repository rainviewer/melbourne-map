#!/usr/bin/env bash

# Compiling carto css style and generates OSM xml
# that can be passed to mapnik.

carto /openstreetmap-carto/project.mml > /map_data/stylesheet_.xml

DS='<Parameter name=\"dbname\"><![CDATA[gis]]><\/Parameter>\
    <Parameter name=\"host\"><![CDATA[postgis]]><\/Parameter>\
    <Parameter name=\"port\"><![CDATA[5432]]><\/Parameter>\
    <Parameter name=\"user\"><![CDATA[postgres]]><\/Parameter>\
    <Parameter name=\"password\"><![CDATA[postgres]]><\/Parameter>'
sed -e "s/<Parameter name=\"dbname\">.*<\/Parameter>/${DS}/" \
    -e "s/<Map /<Map buffer-size=\"256\" /" \
    -e "s/<TextSymbolizer /<TextSymbolizer avoid-edges=\"true\" /" /map_data/stylesheet_.xml > /map_data/stylesheet.xml
rm /map_data/stylesheet_.xml
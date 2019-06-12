FROM dpokidov/gopnik

RUN apt-get update && \
    apt-get install -y git curl unzip node-carto mapnik-utils fontconfig && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /
RUN wget https://github.com/adobe-fonts/source-sans-pro/archive/2.045R-ro/1.095R-it.tar.gz && \
    tar -xzvf 1.095R-it.tar.gz && \
    mkdir /usr/share/fonts/truetype/sourcepro-ttf/ && \
    cp source-sans-pro-2.045R-ro-1.095R-it/TTF/*.ttf /usr/share/fonts/truetype/sourcepro-ttf/ && \
    fc-cache && \
    rm 1.095R-it.tar.gz && \
    rm -rf source-sans-pro-2.045R-ro-1.095R-it

RUN git clone https://github.com/dooman87/openstreetmap-carto.git
WORKDIR /openstreetmap-carto
ADD shapes/ data/
RUN shapeindex --shape_files \
    data/simplified-water-polygons-complete-3857/simplified_water_polygons.shp \
    data/water-polygons-split-3857/water_polygons.shp \
    data/antarctica-icesheet-polygons-3857/icesheet_polygons.shp \
    data/antarctica-icesheet-outlines-3857/icesheet_outlines.shp \
    data/ne_110m_admin_0_boundary_lines_land/ne_110m_admin_0_boundary_lines_land.shp

RUN mkdir /map_data
VOLUME /map_data

RUN mkdir /scripts
COPY scripts/compile_style.sh /scripts
COPY scripts/run_render.sh /scripts
COPY entrypoint.sh /

RUN chmod 755 /scripts/*.sh && \
    chmod 755 /entrypoint.sh

WORKDIR /
ENTRYPOINT /entrypoint.sh

// ---------------------------------------------------------------------
// Common Colors

// You don't need to set up @variables for every color, but it's a good
// idea for colors you might be using in multiple places or as a base
// color for a variety of tints.
// Eg. @water is used in the #water and #waterway layers directly, but
// also in the #water_label and #waterway_label layers inside a color
// manipulation function to get a darker shade of the same hue.
@land: #f8f4f0;
@water: desaturate(lighten(#a0c8f0,5),10);
@water_dark: #185869;  // for the inline/shadow
@crop: #eeeed4;
@grass: fadeout(#e7ebd1,10);
@scrub: fadeout(#e0e8cd,10);
@wood: fadeout(#d4e2c6,15);
@snow: #f4f8ff;
@rock: #ddd;
@sand: mix(#ffd,@land,33%);
// These colors need to take `comp-op:multiply` into account:
@cemetery: #edf4ed;
@pitch: fadeout(#fff,50%);
@park: #edf9e4;
@piste: mix(blue,@land,5);
@school: #fbf6ff;
@hospital: #fff0f0;
@builtup: #f6faff;
Map {
  background-color:@land;
}

// ---------------------------------------------------------------------
// Political boundaries

#admin {
  opacity: 0.5;
  line-join: round;
  line-color: #446;
  [maritime=1] {
    // downplay boundaries that are over water
    line-color: @water;
  }
  // Countries
  [admin_level=2] {
    line-width: 0.8;
    line-cap: round;
    [zoom>=4] { line-width: 1.2; }
    [zoom>=6] { line-width: 2; }
    [zoom>=8] { line-width: 4; }
    [disputed=1] { line-dasharray: 4,4; }
  }
  // States / Provices / Subregions
  [admin_level>=3] {
    line-width: 0.3;
    line-dasharray: 10,3,3,3;
    [zoom>=6] { line-width: 1; }
    [zoom>=8] { line-width: 1.5; }
    [zoom>=12] { line-width: 2; }
  }
}

// ---------------------------------------------------------------------
// Water Features 

#water {
  polygon-fill: @water - #111;
  // Map tiles are 256 pixels by 256 pixels wide, so the height 
  // and width of tiling pattern images must be factors of 256. 
  polygon-pattern-file: url(pattern/wave.png);
  [zoom<=5] {
    // Below zoom level 5 we use Natural Earth data for water,
    // which has more obvious seams that need to be hidden.
    polygon-gamma: 0.4;
  }
  ::blur {
    // This attachment creates a shadow effect by creating a
    // light overlay that is offset slightly south. It also
    // create a slight highlight of the land along the
    // southern edge of any water body.
    polygon-fill: #f0f0ff;
    comp-op: soft-light;
    image-filters: agg-stack-blur(1,1);
    polygon-geometry-transform: translate(0,1);
    polygon-clip: false;
  }
}

#waterway {
  line-color: @water * 0.9;
  line-cap: round;
  line-width: 0.5;
  [class='river'] {
    [zoom>=12] { line-width: 1; }
    [zoom>=14] { line-width: 2; }
    [zoom>=16] { line-width: 3; }
  }
  [class='stream'],
  [class='stream_intermittent'],
  [class='canal'] {
    [zoom>=14] { line-width: 1; }
    [zoom>=16] { line-width: 2; }
    [zoom>=18] { line-width: 3; }
  }
  [class='stream_intermittent'] { line-dasharray: 6,2,2,2; }
}



// Landcover
#landcover {
  polygon-opacity: 0.5; 
  [class='wood'] { polygon-fill: @wood; }
  [class='scrub'] { polygon-fill: @scrub; }
  [class='grass'] { polygon-fill: @grass; }
  [class='crop'] { polygon-fill: @crop; }
  [class='snow'] { polygon-fill: @snow; }
  // fade out stronger classes at high zooms,
  // let more detailed OSM data take over a bit:
  [class='wood'][zoom>=14],
  [class='scrub'][zoom>=15],
  [class='grass'][zoom>=16] {
    [zoom>=15] { polygon-opacity: 0.5; }
    [zoom>=16] { polygon-opacity: 0.4; }
    [zoom>=17] { polygon-opacity: 0.2; }
  }
}
// ---------------------------------------------------------------------
// Landuse areas 

#landuse {
  // Land-use and land-cover are not well-separated concepts in
  // OpenStreetMap, so this layer includes both. The 'class' field
  // is a highly opinionated simplification of the myriad LULC
  // tag combinations into a limited set of general classes.
  [class='park'] { polygon-fill: #d8e8c8; polygon-opacity: 0.5;}
  [class='cemetery'] { polygon-fill: mix(#d8e8c8, #ddd, 25%); }
  [class='hospital'] { polygon-fill: #fde; }
  [class='school'] { polygon-fill: #f0e8f8; }
  ::overlay {
    // Landuse classes look better as a transparent overlay.
    opacity: 0.05;
    [class='wood'] { polygon-fill: #6a4; polygon-gamma: 0.5; }
  }
}

// Hillshading //

#hillshade {
  ::0[zoom<=13],
  ::1[zoom=14],
  ::2[zoom>=15][zoom<=16],
  ::3[zoom>=17][zoom<=18],
  ::4[zoom>=19] {
    comp-op: hard-light;
    polygon-clip: false;
    image-filters-inflate: true;
    [class='shadow'] {
      polygon-fill: #444;
      polygon-opacity: 0.1;
      [zoom>=15][zoom<=16] { polygon-opacity: 0.075; }
      [zoom>=17][zoom<=18] { polygon-opacity: 0.05; }
      [zoom>=18] { polygon-opacity: 0.025; }
    }
    [class='highlight'] {
      polygon-fill: #fff;
      polygon-opacity: 0.2;
      [zoom>=15][zoom<=16] { polygon-opacity: 0.3; }
      [zoom>=17][zoom<=18] { polygon-opacity: 0.2; }
      [zoom>=18] { polygon-opacity: 0.1; }
    }
  }
  ::1 { image-filters: agg-stack-blur(2,2); }
  ::2 { image-filters: agg-stack-blur(4,4); }
  ::3 { image-filters: agg-stack-blur(20,20); }
  ::4 { image-filters: agg-stack-blur(20,20); }
}


// ---------------------------------------------------------------------
// Aeroways 

#aeroway [zoom>=12] {
  ['mapnik::geometry_type'=2] {
    line-color: @land * 0.96;
    [type='runway'] { line-width: 5; }    
    [type='taxiway'] {  
      line-width: 1;
      [zoom>=15] { line-width: 2; }
    }
  }    
  ['mapnik::geometry_type'=3] {
    polygon-fill: @land * 0.96;
    [type='apron'] {
      polygon-fill: @land * 0.98;  
    }  
  }
}

// ---------------------------------------------------------------------
// Contour lines and labels

#contour.line::line [zoom>=13] {
  line-color: #909090;
  line-width: 0.15;
  line-opacity: 0.35;
  [zoom>=15] { line-width: 0.5; }
  [zoom>=16] { line-width: 1; }
  [index=10] { 
    line-width: 0.3; 
    [zoom>=15] { line-width: 0.4; }
  }
}

#contour.label::label {
  [index=10][zoom>=13] {
    text-name: "[ele]+'m'";
    text-face-name: @sans;
    text-placement: line;
    text-size: 8;
    text-character-spacing: 1;
    text-fill: #555;
    text-halo-fill: fadeout(lighten(@land,10), 90);
    text-halo-radius: 1.5;
    text-halo-rasterizer: fast;
    text-avoid-edges: true;
    text-max-char-angle-delta: 30;
  }
}
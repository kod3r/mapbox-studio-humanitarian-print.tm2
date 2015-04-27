/* ****************************************************************** */
/* OSM BRIGHT for Imposm                                              */
/* ****************************************************************** */

/* For basic style customization you can simply edit the colors and
 * fonts defined in this file. For more detailed / advanced
 * adjustments explore the other files.
 *
 * GENERAL NOTES
 *
 * There is a slight performance cost in rendering line-caps.  An
 * effort has been made to restrict line-cap definitions to styles
 * where the results will be visible (lines at least 2 pixels thick).
 */

/* ================================================================== */
/* FONTS
/* ================================================================== */

/* directory to load fonts from in addition to the system directories */
//Map { font-directory: url(./fonts); }

/* set up font sets for various weights and styles */
@sans_lt:           "Open Sans Regular","Arial Unicode MS Regular";
@sans_lt_italic:    "Open Sans Italic","Arial Unicode MS Regular";
@sans:              "Open Sans Semibold","Arial Unicode MS Regular";
@sans_bold:         "Open Sans Bold","Arial Unicode MS Regular";
@sans_italic:       "Open Sans Semibold Italic","Arial Unicode MS Regular";
@sans_bold_italic:  "Open Sans Bold Italic","Arial Unicode MS Regular";

/* Some fonts are larger or smaller than others. Use this variable to
   globally increase or decrease the font sizes. */
/* Note this is only implemented for certain things so far */
@text_adjust: 0;

/* ================================================================== */
/* LANDUSE & LANDCOVER COLORS
/* ================================================================== */

@land:              #F7F6F1;
@water:             #90cccb; //#79c1c0
@beach:             #EEE5B2;
@cemetery:          #D6DED2;
@military:          #D1BFAA;
@wetland:           #e3e9e2; //#CFDCD3;
@peak:              #69623c;
@salt:              #ecf0f1;
/* Greens */
@park:              #D0DCAE; //#86ac86
@wooded:            #B2C29D; //#95ae79;
@grass:             @park;
@agriculture:       #ff0000; //#c7c78d; //#C3D9AD;
@heath:             #E1E9D6;
@sports:            @park;

@residential:       darken(@land,5%);
@commercial:        @land * 0.97;
@industrial:        #D7C8CB;

@building:          #dcd7d7;
@building_hedge:    #dcd7d7;
@collapsed:         #b25047;
@damaged:           #c87c38;
@hospital:          rgb(229,198,195);
@school:            #E2D6CD;


/* ================================================================== */
/* ROAD COLORS
/* ================================================================== */

/* For each class of road there are three color variables:
 * - line: for lower zoomlevels when the road is represented by a
 *         single solid line.
 * - case: for higher zoomlevels, this color is for the road's
 *         casing (outline).
 * - fill: for higher zoomlevels, this color is for the road's
 *         inner fill (inline).
 */

/* ================================================================== */
/* ROAD SURFACES
/* ================================================================== */

// Basic color palette, from which variations will be derived.
@motorway:          #a098b0;
@main:              #d2938e;
@street:            #e9cbb0;
@street_limited:    #e6eaa1;

@track_line:        #BFA286;
@track_fill:        @unpaved; //#E4DAD0;
@track_case:        @unpaved_case;

@pedestrian_line:   #CBC5BF;
@pedestrian_fill:   #BFA286;
@pedestrian_case:   @land;

@cycle_line:        @standard_line;
@cycle_fill:        #FAFAF5;
@cycle_case:        @land;

@rail_line:         #999;
@rail_fill:         #fff;
@rail_case:         @land;

@aeroway:           #ddd;

/* ================================================================== */
/* BOUNDARY COLORS
/* ================================================================== */

@admin_2:           #537076;
@admin_3:           #AEA6A5;
@admin_2_text:      @admin_2;
@admin_3_text:      @admin_3;

/* ================================================================== */
/* LABEL COLORS
/* ================================================================== */

/* We set up a default halo color for places so you can edit them all
   at once or override each individually. */
@place_halo:        fadeout(#fff,34%);

@country_text:      #435;
@country_halo:      @place_halo;

@capital_text:      @country_text;
@capital_halo:      @country_halo;

@state_text:        #a6a6aa;
@state_halo:        @place_halo;

@city_text:         #222;
@city_halo:         @place_halo;

@town_text:         #444;
@town_halo:         @place_halo;

@poi_text:          #537076;
@poi_text2:         #868E90;
@poi_halo:          @place_halo;

@road_text:         #525252;
@road_halo:         #fff;

@other_text:        #888;
@other_halo:        @place_halo;

@locality_text:     #aaa;
@locality_halo:     @land;

/* Also used for other small places: hamlets, suburbs, localities */
@village_text:      #888;
@village_halo:      @place_halo;


/* ================================================================== */
/* OTHERS
/* ================================================================== */

@contour_line:      #d2ccb0;
@power_line:        #7a5960;

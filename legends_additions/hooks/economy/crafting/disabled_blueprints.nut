//food crafting
::mods_hookExactClass("crafting/blueprints/fermented_unhold_heart_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_beer_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_bread_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_cooking_spices_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_cured_rations_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_cured_venison_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_dried_fruits_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_pie_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_porridge_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_pudding_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_smoked_ham_blueprint", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_wine_blueprint", function(o) { o.isValid <- function(){ return false; }});

//FEATURE_1: go disable various blueprints
//paint
::mods_hookExactClass("crafting/blueprints/paint_remover_blueprint", function(o) { o.isValid <- function(){ return false; }});
//crafting\blueprints\hexen_trophy_blueprint.nut

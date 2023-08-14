//3. add more anatomists to the world
::mods_hookExactClass("entity/world/attached_location/herbalists_grove_location", function (o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		onUpdateDraftList(_list, _gender);
		_list.push("anatomist_background");
	}
});

::mods_hookExactClass("entity/world/attached_location/pig_farm_location", function (o)
{

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		onUpdateDraftList(_list, _gender);
		_list.push("anatomist_background");
	}
});

::mods_hookExactClass("entity/world/settlements/buildings/taxidermist_building", function (o)
{

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		onUpdateDraftList(_list, _gender);
		_list.push("anatomist_background");
	}
});

::LA.addAnatomists <- function (list_of_lists)
{
	foreach (lst in list_of_lists)
	{
		lst.push("anatomist_background");
	}

}

::mods_hookExactClass("entity/world/settlements/legends_coast_fort", function (o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		::LA.addAnatomists(this.m.DraftLists);
	}
});

::mods_hookExactClass("entity/world/settlements/legends_forest_fort", function (o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		::LA.addAnatomists(this.m.DraftLists);
	}
});

::mods_hookExactClass("entity/world/settlements/legends_snow_fort", function (o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		::LA.addAnatomists(this.m.DraftLists);
	}
});

::mods_hookExactClass("entity/world/settlements/legends_swamp_fort", function (o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		::LA.addAnatomists(this.m.DraftLists);
	}
});

::mods_hookExactClass("entity/world/settlements/large_coast_fort", function (o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList.push("anatomist_background");
		this.m.DraftList.push("legend_inventor_background");
	}
});

::mods_hookExactClass("entity/world/settlements/large_forest_fort", function (o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList.push("anatomist_background");
	}
});

::mods_hookExactClass("entity/world/settlements/large_snow_fort", function (o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList.push("anatomist_background");
	}
});
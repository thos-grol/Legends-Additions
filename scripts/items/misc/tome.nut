//TODO: on pay day search through all bros -> if (bright) search bags for tomes. -> if (has tome) tick()
//TODO: create tome data structure
this.tome <- this.inherit("scripts/items/item", {
	m = {
        Tome = ""
    },
	function create()
	{
		this.item.create();
		this.m.ID = "misc.ornate_tome";
		this.m.Name = "Ornate Tome";
		this.m.Description = "A well preserved tome";
		this.m.Icon = "loot/inventory_loot_08.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Loot;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 595;
	}

    function tick() //called on wage updates
    {
        progress_current_project();
    }

    function set_tome(_str) //called on enemy drops
    {
        this.m.Tome = _str;
    }


    //Helper fns

    function progress_current_project()
    {
        local ret = get_current_project();

        if (ret.Complete)
        {

        }
        else
        {

        }
        
        //TODO: progress_current_project
        check for tome_id flag existence: tome_id + "_progress"
        //get's the current perk to learn,
        //if there is no more projects then
            //set project to replace meditation perk if it is different
            //else 
    }


    function get_current_project()
    {
        //TODO: get_current_meditation_perk
        local ret = {
            Project = null,
            Complete = false
        };
        local project_flag = null;
        for projects in map[tome_id]
        {
            if (actor.hasflag(projects.flag)) continue;
            ret.push(projects.flag);
            break;
        }

        if (ret.Project == null)
        {
            ret.Project = //meditation_flag;
            ret.Complete = true;
        }

        return ret
    }

    function reward_current_project()
    {
        //TODO: progress_current_project
        if (meditationproject)
        {
            if (no meditation perk)
                add_meditation_perk()
            else if (full completion && different meditation perk)
            {
                swap it out
            }
            return;
        }

    }

    //TODO: structure, use maps to store the data, and then set the type and serialize it to store

    //////////////////////

	function getName()
    {
        return //TODO:
    }

    function getTooltip()
	{
		//TODO: getTooltip
        local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

    //TODO: serialize functions

});


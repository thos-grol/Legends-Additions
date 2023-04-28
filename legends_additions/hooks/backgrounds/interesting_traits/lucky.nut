::mods_hookExactClass("skills/traits/lucky_trait", function (o)
{
    o.create = function()
	{
		this.character_trait.create();
		this.m.ID = "trait.lucky";
		this.m.Name = "Lucky";
		this.m.Icon = "ui/traits/trait_icon_54.png";
		this.m.Description = "Luck is also strength. This character has a natural talent for getting out of harm\'s way in the last second.";
		this.m.Titles = [
			"the Lucky",
			"the Blessed"
		];
		this.m.Excluded = [
			"trait.pessimist",
			"trait.clumsy",
			"trait.ailing",
			"trait.clubfooted"
		];
	}

    o.getTooltip = function()
	{
		local ret = [
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

        ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a " + ::MSU.Text.colorGreen( this.getRerollChance() ) + "% chance to have any attacker require two successful attack rolls in order to hit"
        });

		return ret;
	}

	o.onUpdate = function( _properties )
	{
		_properties.RerollDefenseChance += this.getRerollChance();
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("Lucky")) return;

		local tier = 1;
		local roll = this.Math.rand(1, 100);
		if (roll <= 1) tier = 9; //Heaven Defying Fortune
		if (roll <= 5) tier = 5; //Plane's Chosen
		if (roll <= 20) tier = 3; //Fortunate
		else tier = 1; //Lucky
		
		actor.getFlags().add("Lucky", tier);
	}

	o.boostLuck <- function()
	{
		if (tier == 1) tier = 3;
		else if (tier == 3) tier = 5;
		else if (tier == 5) tier = 9;
	}

	o.getRerollChance <- function()
	{
		return 10 * this.getContainer().getActor().getFlags().getAsInt("Lucky");
	}

	o.getName <- function()
	{
		switch(this.getContainer().getActor().getFlags().getAsInt("Lucky"))
		{
			case 1:
				return "Lucky"
			case 3:
				return "Fortune's Favored"
			case 5:
				return "Chosen One"
			case 9:
				return "Fortune Rivalling Heaven"
		}
	}

	o.getDescription <- function()
	{
		switch(this.getContainer().getActor().getFlags().getAsInt("Lucky"))
		{
			case 1:
				return "Luck is also strength. Things just seem to go right for the character."
			case 3:
				return "Luck is intangible, but it is also strength. This character is extremely fortunate which will help them survive in this profession."
			case 5:
				return "This character is the chosen one. Their luck represents the trend of the world."
			case 9:
				return "This character's luck defies the balance of heaven. Their enemies might choke to death on air before hitting them."
		}
	}
});

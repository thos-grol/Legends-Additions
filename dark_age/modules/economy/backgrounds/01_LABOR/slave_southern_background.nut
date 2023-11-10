::mods_hookExactClass("skills/backgrounds/slave_southern_background", function(o) {
	
	o.setGender_event <- function ()
	{
		if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = ::Const.Bodies.SouthernFemale;
			this.m.Faces = ::Const.Faces.SouthernFemale;
			this.m.Hairs = ::Const.Hair.SouthernFemale;
			this.m.HairColors = ::Const.HairColors.Southern;
		}
		else
		{
			this.m.Bodies = ::Const.Bodies.AfricanFemaleSkinny;
			this.m.Faces = ::Const.Faces.AfricanFemale;
			this.m.Hairs = ::Const.Hair.SouthernFemale;
			this.m.HairColors = ::Const.HairColors.African;
		}

		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(::Const.BackgroundType.Female);
		this.m.GoodEnding = "You purchased %name% as an indebted for almost no gold and continued to pay her a \'slave\'s wage\' for her stay as a sellsword. She did make herself an effective fighter, no doubt believing it was better to be paid nothing and fight to stay alive than be paid nothing and give up and rot. After your departure, you heard that the %companyname% traveled south on a campaign and the indebted got a good chance to exact a fair bit of revenge on a number of enemies in her past. Thankfully, she does not consider you one such person despite having kept her enslaved.";
		this.m.BadEnding = "You purchased %name% as an indebted and after your retiring, she went on with the %companyname%. Word of the mercenary band\'s problems have trickled in, but nothing about the indebted\'s current situation. Knowing how this world works, she has either been put into the vanguard as fodder or perhaps even been sold off to recoup profits. Either way, the world isn\'t easy on a sellsword, and it isn\'t easy on an indebted, and the woman is unfortunately both.";
	}

});

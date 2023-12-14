this.cursed_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.cursed";
		this.m.Name = "Cursed";
		this.m.Description = "";
		this.m.Icon = "ui/perks/perk_01.png";
		this.m.IconMini = "perk_01_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsHidden = true;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		_properties.Hitpoints = ::Math.max(0, _properties.Hitpoints - getCursePointsOverflow() * 10);

		if (_properties.Hitpoints == 0)
		{
			actor.getItems().transferToStash(this.World.Assets.getStash());
			actor.getSkills().onDeath(::Const.FatalityType.None);
			this.World.Statistics.addFallen(actor, "Was hollowed out by curses");
			this.World.getPlayerRoster().remove(actor);
			return;
		}
	}

	function getCursePoints()
	{
		local curse = 0;
		local actor = this.getContainer().getActor();
		local items = actor.getItems().getAllItems();
		foreach(i in items)
		{
			if (!("CursePoints" in i.m)) continue;
			curse += i.m.CursePoints;
		}
		return curse;
	}

	function getCursePointsOverflow()
	{
		local curse = getCursePoints();
		local actor = this.getContainer().getActor();
		local lucky = actor.getSkills().getSkillByID("trait.lucky");
		if (lucky != null)
		{
			local luck = lucky.getLuckyPoints();
			curse = ::Math.max(0, curse - luck);
		}
		return curse;
	}

});


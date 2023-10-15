::Const.Strings.PerkName.StanceBreakthrough <- "Breakthrough";
::Const.Strings.PerkDescription.StanceBreakthrough <- ::MSU.Text.color(::Z.Log.Color.Purple, "Stance")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Turn End, Spear Equipped:")
+ "\n Perform " + ::MSU.Text.colorGreen("X") + " free attacks"
+ "\n " + ::MSU.Text.colorRed("X is the number of enemy_tiles in ZOC");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceBreakthrough].Name = ::Const.Strings.PerkName.StanceBreakthrough;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceBreakthrough].Tooltip = ::Const.Strings.PerkDescription.StanceBreakthrough;

this.perk_stance_breakthrough <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.stance.breakthrough";
		this.m.Name = ::Const.Strings.PerkName.StanceBreakthrough;
		this.m.Description = ::Const.Strings.PerkDescription.StanceBreakthrough;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Stance", true);
	}

	function isEnabled()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getCurrentProperties().IsAbleToUseWeaponSkills) return false; //isDisarmed
		local weapon = actor.getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Spear)) return false;
		return true;
	}

	function onTurnEnd()
	{
		if (!isEnabled()) return;
		local actor = this.getContainer().getActor();
		local enemy_tiles = [];
		foreach (tile in ::Z.getNeighbors(actor.getTile()))
		{
			if (tile.IsOccupiedByActor && !tile.getEntity().isAlliedWithPlayer()) enemy_tiles.push(tile);
		}
		if (enemy_tiles.len() <= 0) return;

		local skill = actor.m.Skills.getAttackOfOpportunity();
		if (skill == null) return;

		for( local i = 0; i < enemy_tiles.len(); i++)
		{
			local info = {
				User = actor,
				Skill = skill,
				TargetTile = ::MSU.Array.rand(enemy_tiles)
			};
			::Time.scheduleEvent(this.TimeUnit.Virtual, ::Math.floor(::Const.Combat.RiposteDelay * i / 2), this.onRiposte, info);
		}

	}

	function onRiposte( _info )
	{
		_info.Skill.useForFree(_info.TargetTile);
	}
});
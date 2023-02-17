this.eldritch_blast_toggle <- this.inherit("scripts/skills/skill", {
	m = {
		IsOn = false	
	},
	function create()
	{
		this.m.ID = "actives.eldritch_blast_toggle";
		this.m.Name = "Grasp of Hadar";
		this.m.Description = "Decide whether your eldritch blasts will pull or push the target."
		this.m.Icon = "skills/eldritch_blast.png";
		this.m.IconDisabled = "skills/eldritch_blast_bw.png";		
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Eldritch blast is currently " + (this.m.IsOn ? "[color=" + ::Const.UI.Color.PositiveValue + "]pulling[/color]" : "[color=" + ::Const.UI.Color.NegativeValue + "]pushing[/color]")
		});
		
		return tooltip;
	}

	function isHidden()
	{
		if (!this.getContainer().getActor().isPlayerControlled()) return true;
		return false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		this.modifyPreviewField(this, "FatigueCost", 15, false);
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsOn = !this.m.IsOn;
		this.m.Icon = this.m.IsOn ? "skills/eldritch_blast.png" : "skills/eldritch_blast_bw.png";
		this.getContainer().getSkillByID("actives.eldritch_blast").m.IsPull = this.m.IsOn;
		return true;
	}
});

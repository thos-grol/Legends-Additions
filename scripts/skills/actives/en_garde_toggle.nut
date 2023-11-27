this.en_garde_toggle <- ::inherit("scripts/skills/skill", {
	m = {
		IsOn = true,
		IsSpent = false,
		FatigueRequired = 15
	},
	function create()
	{
		this.m.ID = "special.en_garde_toggle";
		this.m.Name = "Toggle Riposte";
		this.m.Description = "Toggle automatic riposte"
		this.m.Icon = "skills/riposte_toggle.png";
		this.m.IconDisabled = "skills/riposte_toggle_bw.png";
		this.m.ReturnFavorSounds <- [
			"sounds/combat/return_favor_01.wav"
		];
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
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Automatic riposte is currently " + (this.m.IsOn ? "[color=" + ::Const.UI.Color.PositiveValue + "]Enabled[/color]" : "[color=" + ::Const.UI.Color.NegativeValue + "]Disabled[/color]")
		});

		return tooltip;
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Sword)) return false;
		return true;
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isPlacedOnMap() || !this.isEnabled();
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onUpdate( _properties )
	{
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function pickSkill()
	{
		if (this.m.IsSpent || !this.isEnabled()) return null;

		if (this.getContainer().getActor().getFatigueMax() - this.getContainer().getActor().getFatigue() < this.m.FatigueRequired) return null;

		local riposte = this.getContainer().getSkillByID("actives.riposte");
		if (riposte != null) return riposte;
		else return ::new("scripts/skills/effects/return_favor_effect");
	}

	function onTurnEnd()
	{
		local i = 1;
		if (this.m.IsSpent || !this.m.IsOn) return;

		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || !actor.hasZoneOfControl() || ::Tactical.State.isAutoRetreat()) return;
		::logInfo("Reached " + i++);

		local skill = this.pickSkill();
		if (skill != null)
		{
			::logInfo("Reached " + i++);
			if (skill.getID() == "actives.riposte")
			{
				::logInfo("Reached " + i++);
				skill.useForFree(actor.getTile());
			}
			else
			{
				::logInfo("Reached " + i++);
				this.getContainer().add(skill);
				if (actor.getTile().IsVisibleForPlayer)
				{
					::Sound.play(this.m.ReturnFavorSounds[::Math.rand(0, this.m.ReturnFavorSounds.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, actor.getPos());
				}
			}
		}
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		this.modifyPreviewField(this, "FatigueCost", 15, false);
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsOn = !this.m.IsOn;
		this.m.Icon = this.m.IsOn ? "skills/riposte_toggle.png" : "skills/riposte_toggle_bw.png";
		return true;
	}
});

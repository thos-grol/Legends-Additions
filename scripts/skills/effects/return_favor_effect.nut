this.return_favor_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.return_favor";
		this.m.Name = "Return Favor";
		this.m.Description = "This character has assumed a defensive stance seeking to incapacitate anyone attacking.";
		this.m.Icon = "ui/perks/perk_31.png";
		this.m.IconMini = "perk_31_mini";
		this.m.Overlay = "perk_31";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color] chance to daze missing with a melee attack (resistances and immunities still apply)."
			}
		];
	}

	function onMissed( _attacker, _skill )
	{
		local user = this.getContainer().getActor();

		if (!_skill.isRanged())
		{
			local attack = this.getContainer().getSkillByID("actives.hand_to_hand");
			if (attack != null) attack.useForFree(_targetTile);

			if (this.Math.rand(1, 100) <= 50 && !_attacker.getCurrentProperties().IsImmuneToStun && !_attacker.getSkills().hasSkill("effects.stunned"))
			{
				local d = _attacker.getTile().getDistanceTo(user.getTile());
				local item = user.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);

				if (d <= 1 )
				{
					_attacker.getSkills().add(::new("scripts/skills/effects/dazed_effect"));

					if (!user.isHiddenToPlayer() && !_attacker.isHiddenToPlayer())
					{
						this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_attacker) + " has been dazed for one turn");
					}
				}
			}
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});


::mods_hookExactClass("skills/special/mood_check", function (o)
{
    o.m.Stacks <- 0;
	o.m.MaxStacks <- 25;

    o.create = function()
	{
		this.m.ID = "special.mood_check";
		this.m.Name = "Details";
		this.m.Icon = "ui/perks/back_to_basics_circle.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.Order = ::Const.SkillOrder.Background + 5;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = true;
	}

    o.getDescription <- function()
	{
		return "Provides details about the character's progression and armor.";
	}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();



		local total_weight = getTotalWeight();
		local armor = 1;
		if (total_weight <= 20) armor = 1;
        else if (total_weight > 20 && total_weight <= 40) armor = 2;
        else if (total_weight > 40) armor = 3;

		local armor_class = "";
		switch(armor)
		{
			case 1:
				armor_class = "Light";
				break;
			case 2:
				armor_class = "Medium";
				break;
			case 3:
				armor_class = "Heavy";
				break;
		}

		//TODO:  Heavy, man of steel
		// "Man of Steel
		// Gain 10% of the current condition of the armor piece hit by an attack as a reduction in armor penetration."

        tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Armor class: " + armor_class + " ([color=" + this.Const.UI.Color.PositiveValue + "]" + total_weight + "[/color])"
		});
        if (total_weight <= 20) getTooltip_FreedomOfMovement(tooltip);
        else if (total_weight > 20 && total_weight <= 40) getTooltip_InTheZone(tooltip);
        else if (total_weight > 40) getTooltip_FullForce(tooltip, total_weight);
		return tooltip;
	}

	o.onUpdate = function( _properties )
	{
        local total_weight = getTotalWeight();

        if (total_weight > 40) //Full Force
        {
            local bonus = ::Math.floor(::Math.abs(total_weight / 5));
            _properties.MeleeDefense += bonus;
            _properties.DamageRegularMin += this.Math.floor(bonus);
		    _properties.DamageRegularMax += this.Math.floor(bonus);
        }
	}

    o.onBeforeDamageReceived <- function( _attacker, _skill, _hitInfo, _properties )
	{
		local total_weight = getTotalWeight();
        if (total_weight <= 20) // Freedom of Movement
        {

            if (_attacker == null || _attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) return;
            local ourCurrentInitiative = this.getContainer().getActor().getInitiative();
            local enemyCurrentInitiative = _attacker.getInitiative();
            local bonus = 1;
            if (ourCurrentInitiative > enemyCurrentInitiative)
            {
                local diff = (ourCurrentInitiative - enemyCurrentInitiative) / 100.0;
                local diffPoint = this.Math.minf(1, this.Math.pow(diff, 0.4)) * 0.8;
                bonus = 1 - diffPoint;
            }
            _properties.DamageReceivedRegularMult *= bonus;
        }
        else if (total_weight > 20 && total_weight <= 40) //In the Zone
        {
            if (_attacker != null && _skill != null && _skill.isAttack()) this.m.Stacks -= 2;
        }
	}

    o.getTotalWeight <- function()
    {
        return this.getContainer().getActor().getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;
    }

// =============================================================================================
// In The Zone
// =============================================================================================

    o.onAfterUpdate <- function( _properties )
	{
		local actor = this.getContainer().getActor();
        local total_weight = getTotalWeight();

		if (!actor.isPlacedOnMap())
		{
			this.m.Stacks = 0;
			if (actor.getInitiative() >= 2 * total_weight)
                this.m.Stacks = this.Math.min(this.m.MaxStacks, this.Math.max(0, total_weight - 15));
		}

		if (total_weight > 20 && total_weight <= 40 && this.m.Stacks > 0)
		{
			local bonus = this.m.Stacks * 0.5;
			_properties.MeleeSkillMult *= 1 + bonus * 0.01;
			if (!actor.isPlacedOnMap() || ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() > 0)
                bonus = bonus * 2;
			_properties.MeleeDamageMult *= 1 + bonus * 0.01;
		}
	}

	o.onMissed <- function( _attacker, _skill )
	{
		local total_weight = getTotalWeight();
		if (total_weight > 20 && total_weight <= 40)
        {
            if (_attacker != null && _skill != null && _skill.isAttack() && !_skill.isRanged()) this.m.Stacks = this.Math.min(this.m.MaxStacks, this.m.Stacks + 1);
        }

	}

// =============================================================================================
// Modular Tooltips
// =============================================================================================

    o.getTooltip_FreedomOfMovement <- function( _tooltip )
	{
		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gain hit point damage reduction proportional to the difference between your current initiative and your attacker\'s, up to 80% for 100 initiative."
		});
		return _tooltip;
	}

    o.getTooltip_FullForce <- function( _tooltip, total_weight)
	{
		local bonus = this.Math.abs(total_weight / 5);
		_tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "+" + ::MSU.Text.colorGreen( bonus ) + " Melee Damage"
		});
        _tooltip.push({
			id = 10,
			type = "text",
            icon = "ui/icons/melee_defense.png",
            text = "+" + ::MSU.Text.colorGreen( bonus ) + " Melee defense"
		});
		return _tooltip;
	}

    o.getTooltip_InTheZone <- function( _tooltip)
	{
		local bonus = this.m.Stacks * 0.5;
		local actor = this.getContainer().getActor();

        _tooltip.push({
            id = 6,
            type = "text",
            icon = "ui/icons/melee_skill.png",
            text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Stacks + "[/color]/25 stacks. Gain stacks when dodging attacks. Lose stacks when hit."
        });

		if (bonus > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] Melee Skill"
			});

			if (!actor.isPlacedOnMap() || ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() > 0)
			{
				bonus = bonus * 2;
			}

			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] Melee Damage"
			});
		}

		if (!actor.isPlacedOnMap())
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "The Melee Damage bonus will be [color=" + this.Const.UI.Color.NegativeValue + "]halved[/color] when not engaged in melee"
			});
		}
		else if (::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true) == 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Melee Damage bonus [color=" + this.Const.UI.Color.NegativeValue + "]halved[/color] due to not being engaged in melee"
			});
		}

		return _tooltip;
	}


// =============================================================================================
// Keep old mood code
// =============================================================================================
    o.onCombatStarted = function()
	{
		local actor = this.getContainer().getActor();
        if (!this.getContainer().getActor().isPlayerControlled()) return;

		local mood = actor.getMoodState();
		local morale = actor.getMoraleState();
		local isDastard = this.getContainer().hasSkill("trait.dastard");

		switch(mood)
		{
            case this.Const.MoodState.Concerned:
                actor.setMaxMoraleState(this.Const.MoraleState.Steady);
                actor.setMoraleState(this.Const.MoraleState.Steady);
                break;

            case this.Const.MoodState.Disgruntled:
                actor.setMaxMoraleState(this.Const.MoraleState.Wavering);
                actor.setMoraleState(this.Const.MoraleState.Wavering);
                break;

            case this.Const.MoodState.Angry:
                actor.setMaxMoraleState(this.Const.MoraleState.Breaking);
                actor.setMoraleState(this.Const.MoraleState.Breaking);
                break;

            case this.Const.MoodState.Neutral:
                actor.setMaxMoraleState(this.Const.MoraleState.Confident);
                break;
            case this.Const.MoodState.InGoodSpirit:
                actor.setMaxMoraleState(this.Const.MoraleState.Confident);
                if (morale < this.Const.MoraleState.Confident && this.Math.rand(1, 100) <= 25 && !isDastard)
                    actor.setMoraleState(this.Const.MoraleState.Confident);
                break;
            case this.Const.MoodState.Eager:
                actor.setMaxMoraleState(this.Const.MoraleState.Confident);
                if (morale < this.Const.MoraleState.Confident && this.Math.rand(1, 100) <= 50 && !isDastard)
                    actor.setMoraleState(this.Const.MoraleState.Confident);
                break;
            case this.Const.MoodState.Euphoric:
                actor.setMaxMoraleState(this.Const.MoraleState.Confident);
                if (morale < this.Const.MoraleState.Confident && this.Math.rand(1, 100) <= 75 && !isDastard)
                    actor.setMoraleState(this.Const.MoraleState.Confident);
                break;
        }
	}
});
::Const.Strings.PerkDescription.LegendSmallTarget = "Use flowing, billowing clothes to distract..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+100") + " Melee and Ranged defence. "  + ::MSU.Text.colorRed("– 1") + " per point of armor and health. "  + ::MSU.Text.colorRed("Tabards") + ", "  + ::MSU.Text.colorRed("Cloaks") + ", and "  + ::MSU.Text.colorRed("Helmet Vanity Layers") + " are not used in calculations."
+ "\n\n" + ::MSU.Text.colorGreen("+100%") + " to reroll incoming hits. "  + ::MSU.Text.colorRed("– 1%") + " chance per point of Melee Defense and Resolve.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSmallTarget].Tooltip = ::Const.Strings.PerkDescription.LegendSmallTarget;

this.perk_legend_small_target <- this.inherit("scripts/skills/skill", {
	m = {
		BonusMin = 0,
	},
	function create()
	{
		this.m.ID = "perk.legend_small_target";
		this.m.Name = this.Const.Strings.PerkName.LegendSmallTarget;
		this.m.Description = "Gains increased Melee and Ranged defense and reroll chance.";
		this.m.Icon = "ui/perks/small_target.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();

		if (bonus > this.m.BonusMin)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
			});
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Defense"
			});
		}
		else if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character needs armor to recieve a defence bonus."
			});
		}

		local bonus2 = this.getBonus2();

		if (bonus2 > this.m.BonusMin)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus2 + "%[/color] chance for enemies to be forced to reroll their attack"
			});
		}
		else
		{
			bonus = this.m.BonusMin;

			if (bonus)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "This character\'s [color=" + this.Const.UI.Color.NegativeValue + "]Melee Defence and Resolve is too high[/color] to gain reroll chance."
				});
			}
		}

		return tooltip;
	}

	function getBonus()
	{
		local stackTotal = 0;
		local actor = this.getContainer().getActor();
		local health = 0;
		health = actor.getBaseProperties().Hitpoints;
		local bodyItem = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local bodyArmor = 0;
		local headItem = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local headArmor = 0;

		if (bodyItem != null)
		{
			bodyArmor = actor.getArmor(this.Const.BodyPart.Body);
		}

		if (headItem != null)
		{
			headArmor = actor.getArmor(this.Const.BodyPart.Head);
		}

		local stackTotal = health + headArmor + bodyArmor;

		if (bodyItem != null)
		{
			local tabard = bodyItem.getUpgrade(this.Const.Items.ArmorUpgrades.Tabbard);
			local cloak = bodyItem.getUpgrade(this.Const.Items.ArmorUpgrades.Cloak);

			if (tabard != null)
			{
				local tabardArmor = tabard.getRepair();
				stackTotal = stackTotal - tabardArmor;
			}

			if (cloak != null)
			{
				local cloakArmor = cloak.getRepair();
				stackTotal = stackTotal - cloakArmor;
			}
		}

		if (headItem != null)
		{
			local vanity = headItem.getUpgrade(this.Const.Items.HelmetUpgrades.Vanity);
			local extra = headItem.getUpgrade(this.Const.Items.HelmetUpgrades.ExtraVanity);

			if (vanity != null)
			{
				local vanityArmor = vanity.getRepair();
				stackTotal = stackTotal - vanityArmor;
			}

			if (extra != null)
			{
				local extraArmor = extra.getRepair();
				stackTotal = stackTotal - extraArmor;
			}
		}

		local bonus = this.Math.max(5, 100 - stackTotal);
		return this.Math.floor(bonus);
	}

	function getBonus2()
	{
		local actor = this.getContainer().getActor();
		local mdef = actor.getCurrentProperties().getMeleeDefense();
		local resolve = actor.getCurrentProperties().getBravery();
		local stack = mdef + resolve;
		local bonus = this.Math.max(10, 100 - stack);
		return this.Math.floor(bonus);
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;

		local bonus2 = this.getBonus2();
		_properties.RerollDefenseChance += bonus2;
	}

});


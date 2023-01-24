this.legend_gladius_named <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_gladius_named";
		this.m.NameList = ::Const.Strings.SwordNames;
		this.m.Description = "A straight blade of ancient origin. The grip and pomel are very plain, from a simpler time.";
		this.m.IconLarge = "weapons/melee/legend_gladius_01_named.png";
		this.m.Icon = "weapons/melee/legend_gladius_named_01_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.ItemType = ::Const.Items.ItemType.Named | ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_gladius_01";
		this.m.Value = 1900;
		this.m.Condition = 54.0;
		this.m.ConditionMax = 54.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 43;
		this.m.RegularDamageMax = 48;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.2;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(::new("scripts/skills/actives/slash"));
		this.addSkill(::new("scripts/skills/actives/riposte"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}
});


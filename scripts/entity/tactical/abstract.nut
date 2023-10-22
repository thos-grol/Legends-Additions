this.abstract <- this.inherit("scripts/entity/tactical/human", {
	m = {
		Level = 3,
		Perks = 2,
		TREE_DEFENSE = null,
		TREE_TRAIT1 = null,
		TREE_TRAIT2 = null,
		TREE_WEAPON = null
	},
	function onInit()
	{
		this.human.onInit();
	}

	function create()
	{
		this.human.create();
		this.m.Level = ::B.Info[this.m.Type].Level;
		this.m.XP = this.m.Level * 35;
		this.m.Perks = this.m.Level - 1;
	}

	function assignRandomEquipment()
	{
		//Assign outfit and get the defense tree
		local weight_armor = 0;
		foreach( item in this.Const.World.Common.pickOutfit(::B.Info[this.m.Type].Outfit) )
		{
			this.m.Items.equip(item);
			weight_armor += item.m.StaminaModifier * -1;
		}

		if (weight_armor <= 20) this.m.TREE_DEFENSE = ::Const.Perks.LightArmorTree.Tree;
        else if (weight_armor <= 40) this.m.TREE_DEFENSE = ::Const.Perks.MediumArmorTree.Tree;
        else this.m.TREE_DEFENSE = ::Const.Perks.HeavyArmorTree.Tree;

		if (builds)
		{
			
			return;
		}

		local weapon = this.assignWeapon();
		local this.m.TREE_WEAPON = this.Const.GetWeaponPerkTree(weapon);
		if (typeof this.m.TREE_WEAPON == "array") this.m.TREE_WEAPON = weaponPerkTree[0];

		for( local i = 0; i < this.m.Level; i = i++)
		{
			decode_add(::B.Info[this.m.Pattern][i]);
		}
		
	}

	function assignWeapon()
	{
		local idx = this.Math.rand(0, this.m.WeaponsAndTrees.len() - 1);
		local selection = this.m.WeaponsAndTrees[idx];
		this.m.Items.equip(this.new(selection[0]));
		return this.getMainhandItem();
	}

	function pickPerk( _purchaseLimit, _table, _cap = 6, _malus = false )
	{
		local tabl = _table.Tree;
		this.pickPerkFromTree(_purchaseLimit, tabl, _cap);
	}

	function assignPerks()
	{
		local idx = this.Math.rand(0, this.m.DefensePerkList.len() - 1);
		this.pickPerk(this.m.PerkPower, this.m.DefensePerkList[idx], this.m.EnemyLevel - 1);

		while (this.m.PerkPower > 0 && this.m.TraitsPerkList.len() != 0)
		{
			local idx = this.Math.rand(0, this.m.TraitsPerkList.len() - 1);
			local selectedTree = this.m.TraitsPerkList.remove(idx);
			this.pickPerk(this.m.PerkPower, selectedTree, this.m.EnemyLevel - 1);
		}
	}

	

	

	//Helper fns

	function writeTablesFromParam( _table )
	{
		foreach( k, v in _table )
		{
			this.m[k] = v;
		}
	}

	function pickPerkFromTree( _purchaseLimit, _tree, _cap = 6 )
	{
		if (_cap > 6)
		{
			_cap = 6;
		}

		if (_cap > _tree.len())
		{
			_cap = _tree.len() - 1;
		}

		for( local i = 0; i <= _cap; i++ )
		{
			local row = _tree[i];

			if (row.len() != 0 && _purchaseLimit > 0)
			{
				local perkDefNum = row[0];
				local fullDef = clone this.Const.Perks.PerkDefObjects[perkDefNum];
				local toAdd = this.new(fullDef.Script);

				if (!this.m.Skills.hasSkill(toAdd.getID()))
				{
					this.m.Skills.add(toAdd);
					_purchaseLimit--;
					this.m.PerkPower--;
				}
			}
		}
	}

});


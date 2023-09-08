::mods_hookExactClass("skills/backgrounds/character_background", function (o){ 
    o.m.PerkTreeDynamicMins = {
        Weapon = 0,
        Defense = 2,
        Traits = 2,
        Enemy = 0,
        EnemyChance = 0,
        Class = 1,
        ClassChance = 0.01,
        Magic = 1,
        MagicChance = 0
    };

    o.buildPerkTree = function()
	{
		local a = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				0
			]
		};

		if (this.m.PerkTree != null)
		{
			return a;
		}

		if (this.m.CustomPerkTree == null)
		{
			local mins = this.getPerkTreeDynamicMins();
			local result = this.Const.Perks.GetDynamicPerkTree(mins, this.m.PerkTreeDynamic, this.getContainer().getActor().getFlags());
			this.m.CustomPerkTree = result.Tree;
			a = result.Attributes;
		}

		local pT = this.Const.Perks.BuildCustomPerkTree(this.m.CustomPerkTree);
		this.m.PerkTree = pT.Tree;
		this.m.PerkTreeMap = pT.Map;
		local origin = this.World.Assets.getOrigin();

		if (origin != null)
		{
			origin.onBuildPerkTree(this);
		}

		return a;
	}

    o.getPerkBackgroundDescription = function( _tree )
	{
		local text = "";
        text = text + this.getContainer().getActor().getFlags().get("traits") + "\n";
		text = text + this.getPerkTreeGroupDescription(_tree.Weapon, "Has an aptitude for");
		text = text + this.getPerkTreeGroupDescription(_tree.Defense, "Likes wearing");
		text = text + this.getPerkTreeGroupDescription(_tree.Enemy, "Prefers fighting");
		text = text + this.getPerkTreeGroupDescription(_tree.Class, "Is skilled in");
		return text;
	}
});


::Const.Perks.GetDynamicPerkTree <- function ( _mins, _map, _flags )
{
	local tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[],
		[],
		[],
		[],
		[]
	];
	local attributes = this.Const.Perks.TraitsTrees.getBaseAttributes();
	local _localMap = {
		Weapon = [],
		Defense = [],
		Traits = [],
		Enemy = [],
		Class = [],
		Magic = []
	};

	if ("Weapon" in _map)
	{
		foreach( p in _map.Weapon )
		{
			_localMap.Weapon.push(p);
		}
	}

	if ("Defense" in _map)
	{
		foreach( p in _map.Defense )
		{
			_localMap.Defense.push(p);
		}
	}

	if ("Traits" in _map)
	{
		foreach( p in _map.Traits )
		{
			_localMap.Traits.push(p);
		}
	}

	if ("Enemy" in _map)
	{
		foreach( p in _map.Enemy )
		{
			_localMap.Enemy.push(p);
		}
	}

	if ("Class" in _map)
	{
		foreach( p in _map.Class )
		{
			_localMap.Class.push(p);
		}
	}

	if ("Magic" in _map)
	{
		foreach( p in _map.Magic )
		{
			_localMap.Magic.push(p);
		}
	}

	local count = _mins.Weapon - _localMap.Weapon.len();

	for( local i = 0; i < count; i = i )
	{
		local _exclude = [];

		foreach( tt in _localMap.Weapon )
		{
			_exclude.push(tt.ID);
		}

		local t = this.Const.Perks.WeaponTrees.getRandom(_exclude);
		_localMap.Weapon.push(t);
		i = ++i;
	}

	local count = _mins.Defense - _localMap.Defense.len();

	for( local i = 0; i < count; i = i )
	{
		local _exclude = [];

		foreach( tt in _localMap.Defense )
		{
			_exclude.push(tt.ID);
		}

		local t = this.Const.Perks.DefenseTrees.getRandom(_exclude);
		_localMap.Defense.push(t);
		i = ++i;
	}

	local count = _mins.Traits - _localMap.Traits.len();

	for( local i = 0; i < count; i = i )
	{
		local _exclude = [];

		foreach( tt in _localMap.Traits )
		{
			_exclude.push(tt.ID);
		}

		local t = this.Const.Perks.TraitsTrees.getRandom(_exclude, _flags);
		_localMap.Traits.push(t);
		i = ++i;
	}

	local count = _mins.Enemy - _localMap.Enemy.len();

	for( local i = 0; i <= count; i = i )
	{
		local r = this.Math.rand(0, 100);

		if (r > _mins.EnemyChance * 100.0)
		{
		}
		else
		{
			local _exclude = [];

			foreach( tt in _localMap.Enemy )
			{
				_exclude.push(tt.ID);
			}

			local t = this.Const.Perks.EnemyTrees.getRandom(_exclude);
			_localMap.Enemy.push(t);
		}

		i = ++i;
	}

	local count = _mins.Class - _localMap.Class.len();

	for( local i = 0; i <= count; i = i )
	{
		local r = this.Math.rand(0, 100);

		if (r > _mins.ClassChance * 100.0)
		{
		}
		else
		{
			local _exclude = [];

			foreach( tt in _localMap.Class )
			{
				_exclude.push(tt.ID);
			}

			local t = this.Const.Perks.ClassTrees.getRandom(_exclude);
			_localMap.Class.push(t);
		}

		i = ++i;
	}

	local count = _mins.Magic - _localMap.Magic.len();

	for( local i = 0; i <= count; i = i )
	{
		local r = this.Math.rand(0, 100);

		if (r > _mins.MagicChance * 100.0)
		{
		}
		else
		{
			local _exclude = [];

			foreach( tt in _localMap.Magic )
			{
				_exclude.push(tt.ID);
			}

			local t = this.Const.Perks.MagicTrees.getRandom(_exclude);

			if (this.LegendsMod.Configs().LegendMagicEnabled())
			{
				_localMap.Magic.push(t);
			}
		}

		i = ++i;
	}

	local _totals = {};
	local _overflows = {};

	foreach( v in _localMap )
	{
		foreach( mT in v )
		{
			foreach( i, row in mT.Tree )
			{
				if (!(i in _totals))
				{
					_totals[i] <- 0;
					_overflows[i] <- [];
				}

				foreach( j, p in row )
				{
					for( ; _totals[i] >= 13;  )
					{
						_overflows[i].push(p);
					}

					_totals[i]++;
					tree[i].push(p);
				}
			}
		}
	}

	foreach( index, L in _overflows )
	{
		local nextIndex = index;
		local foundIndexToSlot = true;

		for( local i = 0; i < L.len(); i = i )
		{
			while (nextIndex < 7 && _totals[nextIndex] >= 13)
			{
				nextIndex++;

				if (nextIndex > 6)
				{
					foundIndexToSlot = false;
				}
			}

			if (foundIndexToSlot == false)
			{
				nextIndex = index;
				foundIndexToSlot = true;

				while (nextIndex > 0 && _totals[nextIndex] >= 13)
				{
					nextIndex--;

					if (nextIndex < 0)
					{
						foundIndexToSlot = false;
					}
				}
			}

			if (foundIndexToSlot)
			{
				tree[nextIndex].push(L[i]);
				_totals[nextIndex]++;
			}

			i = ++i;
		}
	}

	foreach( t in _localMap.Traits )
	{
		if (!_flags.has("traits")) _flags.set("traits", "Traits: ");
        _flags.set("traits", _flags.get("traits") + t.Name + ", ");


        if (t.Attributes)
		{
			local c = t.Attributes;
			attributes.Hitpoints[0] += c.Hitpoints[0];
			attributes.Hitpoints[1] += c.Hitpoints[1];
			attributes.Bravery[0] += c.Bravery[0];
			attributes.Bravery[1] += c.Bravery[1];
			attributes.Stamina[0] += c.Stamina[0];
			attributes.Stamina[1] += c.Stamina[1];
			attributes.MeleeSkill[0] += c.MeleeSkill[0];
			attributes.MeleeSkill[1] += c.MeleeSkill[1];
			attributes.MeleeDefense[0] += c.MeleeDefense[0];
			attributes.MeleeDefense[1] += c.MeleeDefense[1];
			attributes.RangedSkill[0] += c.RangedSkill[0];
			attributes.RangedSkill[1] += c.RangedSkill[1];
			attributes.RangedDefense[0] += c.RangedDefense[0];
			attributes.RangedDefense[1] += c.RangedDefense[1];
			attributes.Initiative[0] += c.Initiative[0];
			attributes.Initiative[1] += c.Initiative[1];
		}
	}

	return {
		Tree = tree,
		Attributes = attributes
	};
};
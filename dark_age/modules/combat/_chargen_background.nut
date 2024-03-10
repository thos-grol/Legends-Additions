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
			local result = ::Const.Perks.GetDynamicPerkTree(mins, this.m.PerkTreeDynamic, this.getContainer().getActor().getFlags());
			this.m.CustomPerkTree = result.Tree;
			a = result.Attributes;
		}

		local pT = ::Const.Perks.BuildCustomPerkTree(this.m.CustomPerkTree);
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

	o.buildAttributes = function( _tag = null, _attrs = null )
	{
		local a = [];

		if (_tag == "zombie")
		{
			a = {
				Hitpoints = [
					65,
					75
				],
				Bravery = [
					30,
					40
				],
				Stamina = [
					90,
					100
				],
				MeleeSkill = [
					42,
					52
				],
				RangedSkill = [
					27,
					37
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
					85,
					95
				]
			};
		}
		else if (_tag == "skeleton")
		{
			a = {
				Hitpoints = [
					50,
					60
				],
				Bravery = [
					30,
					40
				],
				Stamina = [
					90,
					100
				],
				MeleeSkill = [
					42,
					52
				],
				RangedSkill = [
					27,
					37
				],
				MeleeDefense = [
					0,
					5
				],
				RangedDefense = [
					0,
					5
				],
				Initiative = [
					90,
					100
				]
			};
		}
		else
		{
			a = {
				//Vitality
				Hitpoints = [
					50,
					50
				],
				//Will
				Bravery = [
					50,
					50
				],
				//Endurance
				Stamina = [
					100,
					100
				],
				//Attack
				MeleeSkill = [
					50,
					50
				],
				//Strength
				RangedSkill = [
					10,
					10
				],
				//Defense
				MeleeDefense = [
					10,
					10
				],
				//Reflex
				RangedDefense = [
					10,
					10
				],
				//Agility
				Initiative = [
					100,
					100
				]
			};
		}

		local c = this.onChangeAttributes();
		a.Hitpoints[0] += c.Hitpoints[0];
		a.Hitpoints[1] += c.Hitpoints[1];
		a.Bravery[0] += c.Bravery[0];
		a.Bravery[1] += c.Bravery[1];
		a.Stamina[0] += c.Stamina[0];
		a.Stamina[1] += c.Stamina[1];
		a.MeleeSkill[0] += c.MeleeSkill[0];
		a.MeleeSkill[1] += c.MeleeSkill[1];
		a.MeleeDefense[0] += c.MeleeDefense[0];
		a.MeleeDefense[1] += c.MeleeDefense[1];
		a.RangedSkill[0] += c.RangedSkill[0];
		a.RangedSkill[1] += c.RangedSkill[1];
		a.RangedDefense[0] += c.RangedDefense[0];
		a.RangedDefense[1] += c.RangedDefense[1];
		a.Initiative[0] += c.Initiative[0];
		a.Initiative[1] += c.Initiative[1];

		if (_attrs != null)
		{
			a.Hitpoints[0] += _attrs.Hitpoints[0];
			a.Hitpoints[1] += _attrs.Hitpoints[1];
			a.Bravery[0] += _attrs.Bravery[0];
			a.Bravery[1] += _attrs.Bravery[1];
			a.Stamina[0] += _attrs.Stamina[0];
			a.Stamina[1] += _attrs.Stamina[1];
			a.MeleeSkill[0] += _attrs.MeleeSkill[0];
			a.MeleeSkill[1] += _attrs.MeleeSkill[1];
			a.MeleeDefense[0] += _attrs.MeleeDefense[0];
			a.MeleeDefense[1] += _attrs.MeleeDefense[1];
			a.RangedSkill[0] += _attrs.RangedSkill[0];
			a.RangedSkill[1] += _attrs.RangedSkill[1];
			a.RangedDefense[0] += _attrs.RangedDefense[0];
			a.RangedDefense[1] += _attrs.RangedDefense[1];
			a.Initiative[0] += _attrs.Initiative[0];
			a.Initiative[1] += _attrs.Initiative[1];
		}

		local b = this.getContainer().getActor().getBaseProperties();
		b.ActionPoints = 9;
		local Hitpoints1 = this.Math.rand(a.Hitpoints[0], a.Hitpoints[1]);
		local Bravery1 = this.Math.rand(a.Bravery[0], a.Bravery[1]);
		local Stamina1 = this.Math.rand(a.Stamina[0], a.Stamina[1]);
		local MeleeSkill1 = this.Math.rand(a.MeleeSkill[0], a.MeleeSkill[1]);
		local RangedSkill1 = this.Math.rand(a.RangedSkill[0], a.RangedSkill[1]);
		local MeleeDefense1 = this.Math.rand(a.MeleeDefense[0], a.MeleeDefense[1]);
		local RangedDefense1 = this.Math.rand(a.RangedDefense[0], a.RangedDefense[1]);
		local Initiative1 = this.Math.rand(a.Initiative[0], a.Initiative[1]);
		local Hitpoints2 = this.Math.rand(a.Hitpoints[0], a.Hitpoints[1]);
		local Bravery2 = this.Math.rand(a.Bravery[0], a.Bravery[1]);
		local Stamina2 = this.Math.rand(a.Stamina[0], a.Stamina[1]);
		local MeleeSkill2 = this.Math.rand(a.MeleeSkill[0], a.MeleeSkill[1]);
		local RangedSkill2 = this.Math.rand(a.RangedSkill[0], a.RangedSkill[1]);
		local MeleeDefense2 = this.Math.rand(a.MeleeDefense[0], a.MeleeDefense[1]);
		local RangedDefense2 = this.Math.rand(a.RangedDefense[0], a.RangedDefense[1]);
		local Initiative2 = this.Math.rand(a.Initiative[0], a.Initiative[1]);
		local HitpointsAvg = this.Math.round((Hitpoints1 + Hitpoints2) / 2);
		local BraveryAvg = this.Math.round((Bravery1 + Bravery2) / 2);
		local StaminaAvg = this.Math.round((Stamina1 + Stamina2) / 2);
		local MeleeSkillAvg = this.Math.round((MeleeSkill1 + MeleeSkill2) / 2);
		local RangedSkillAvg = this.Math.round((RangedSkill1 + RangedSkill2) / 2);
		local MeleeDefenseAvg = this.Math.round((MeleeDefense1 + MeleeDefense2) / 2);
		local RangedDefenseAvg = this.Math.round((RangedDefense1 + RangedDefense2) / 2);
		local InitiativeAvg = this.Math.round((Initiative1 + Initiative2) / 2);
		b.Hitpoints = HitpointsAvg;
		b.Bravery = BraveryAvg;
		b.Stamina = StaminaAvg;
		b.MeleeSkill = MeleeSkillAvg;
		b.RangedSkill = RangedSkillAvg;
		b.MeleeDefense = MeleeDefenseAvg;
		b.RangedDefense = RangedDefenseAvg;
		b.Initiative = InitiativeAvg;
		this.getContainer().getActor().m.CurrentProperties = clone b;
		this.getContainer().getActor().setHitpoints(b.Hitpoints);
		local weighted = [];

		if (a.Hitpoints[1] == a.Hitpoints[0])
		{
			weighted.push(50);
		}
		else
		{
			weighted.push(this.Math.floor((b.Hitpoints - a.Hitpoints[0]) * 100.0 / (a.Hitpoints[1] - a.Hitpoints[0])));
		}

		if (a.Bravery[1] == a.Bravery[0])
		{
			weighted.push(50);
		}
		else
		{
			weighted.push(this.Math.floor((b.Bravery - a.Bravery[0]) * 100.0 / (a.Bravery[1] - a.Bravery[0])));
		}

		if (a.Stamina[1] == a.Stamina[0])
		{
			weighted.push(50);
		}
		else
		{
			weighted.push(this.Math.floor((b.Stamina - a.Stamina[0]) * 100.0 / (a.Stamina[1] - a.Stamina[0])));
		}

		if (a.MeleeSkill[1] == a.MeleeSkill[0])
		{
			weighted.push(50);
		}
		else
		{
			weighted.push(this.Math.floor((b.MeleeSkill - a.MeleeSkill[0]) * 100.0 / (a.MeleeSkill[1] - a.MeleeSkill[0])));
		}

		if (a.RangedSkill[1] == a.RangedSkill[0])
		{
			weighted.push(50);
		}
		else
		{
			weighted.push(this.Math.floor((b.RangedSkill - a.RangedSkill[0]) * 100.0 / (a.RangedSkill[1] - a.RangedSkill[0])));
		}

		if (a.MeleeDefense[1] == a.MeleeDefense[0])
		{
			weighted.push(50);
		}
		else
		{
			weighted.push(this.Math.floor((b.MeleeDefense - a.MeleeDefense[0]) * 100.0 / (a.MeleeDefense[1] - a.MeleeDefense[0])));
		}

		if (a.RangedDefense[1] == a.RangedDefense[0])
		{
			weighted.push(50);
		}
		else
		{
			weighted.push(this.Math.floor((b.RangedDefense - a.RangedDefense[0]) * 100.0 / (a.RangedDefense[1] - a.RangedDefense[0])));
		}

		if (a.Initiative[1] == a.Initiative[0])
		{
			weighted.push(50);
		}
		else
		{
			weighted.push(this.Math.floor((b.Initiative - a.Initiative[0]) * 100.0 / (a.Initiative[1] - a.Initiative[0])));
		}

		return weighted;
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
	local attributes = ::Const.Perks.TraitsTrees.getBaseAttributes();
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

		local t = ::Const.Perks.WeaponTrees.getRandom(_exclude);
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

		local t = ::Const.Perks.DefenseTrees.getRandom(_exclude);
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

		local t = ::Const.Perks.TraitsTrees.getRandom(_exclude, _flags);
		_localMap.Traits.push(t);
		i = ++i;
	}

	local count = _mins.Enemy - _localMap.Enemy.len();

	for( local i = 0; i <= count; i = i )
	{
		local r = ::Math.rand(0, 100);

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

			local t = ::Const.Perks.EnemyTrees.getRandom(_exclude);
			_localMap.Enemy.push(t);
		}

		i = ++i;
	}

	local count = _mins.Class - _localMap.Class.len();

	for( local i = 0; i <= count; i = i )
	{
		local r = ::Math.rand(0, 100);

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

			local t = ::Const.Perks.ClassTrees.getRandom(_exclude);
			_localMap.Class.push(t);
		}

		i = ++i;
	}

	local count = _mins.Magic - _localMap.Magic.len();

	for( local i = 0; i <= count; i = i )
	{
		local r = ::Math.rand(0, 100);

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

			local t = ::Const.Perks.MagicTrees.getRandom(_exclude);

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
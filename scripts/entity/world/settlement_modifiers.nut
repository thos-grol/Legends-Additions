this.settlement_modifiers <- {
	PriceMult = 1.0,
	BuyPriceMult = 1.0,
	SellPriceMult = 1.0,
	FoodPriceMult = 1.0,
	MedicalPriceMult = 1.0,
	BuildingPriceMult = 1.0,
	IncensePriceMult = 1.0,
	BeastPartsPriceMult = 1.0,
	RarityMult = 1.0,
	FoodRarityMult = 1.0,
	MedicalRarityMult = 1.0,
	MineralRarityMult = 1.0,
	BuildingRarityMult = 1.0,
	RecruitsMult = 1.25,
	StablesMult = 1.0,
	function reset()
	{
		this.PriceMult = 1.0;
		this.BuyPriceMult = 1.0;
		this.SellPriceMult = 1.0;
		this.FoodPriceMult = 1.0;
		this.MedicalPriceMult = 1.0;
		this.BuildingPriceMult = 1.0;
		this.IncensePriceMult = 1.0;
		this.BeastPartsPriceMult = 1.0;
		this.RarityMult = 1.0;
		this.FoodRarityMult = 1.0;
		this.MedicalRarityMult = 1.0;
		this.MineralRarityMult = 1.0;
		this.BuildingRarityMult = 1.0;
		this.RecruitsMult = 0.75;
		this.StablesMult = 1.0;

		// if (this.World.Assets.getEconomicDifficulty() == ::Const.Difficulty.Legendary)
		// {
		// 	this.RecruitsMult = 0.5;
		// }
	}

	function create()
	{
	}

};


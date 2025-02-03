return [[
return {
	Name = "statueV2",
	Title = "可互动的庭院雕像",
	Description = "雕像前方的平台将会变为可互动状态,",
	Game = "*",

	Elements = {
		{
			Type = "Button",
			Name = "setnewnewymew",
			Arguments = {
				Text = '启用互动按钮',
				Tooltip = '按下后，当你到达庭院时，雕像面前的展台将是可互动的，按下之后将会播放一段动画',

				Func = function()
					loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/72bd9936249bae4b04ddbd0e05c9b323/raw/3847f62fe7fe2af3e1450fe0f6083b6293a3cb68/cpuntyardorsmth'))()
				end
			},
		}
	}
}
]]

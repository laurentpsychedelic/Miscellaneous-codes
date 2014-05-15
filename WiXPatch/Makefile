buildTargetLayout:
	candle -dVersion=1.0 Product.wxs
	light Product.wixobj -out 1.0/Product.msi

buildUpgradeLayout:
	candle -dVersion=1.1 Product.wxs
	light Product.wixobj -out 1.1/Product.msi

createTransform: buildTargetLayout buildUpgradeLayout
	torch -p -xi 1.0/Product.wixpdb 1.1/Product.wixpdb -out patch/diff.wixmat

buildPatch: createTransform
	candle Patch.wxs
	light Patch.wixobj -out patch/patch.wixmsp
	pyro patch/patch.wixmsp -out patch/patch.msp -t RTM patch/diff.wixmat

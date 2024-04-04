"
<t size='1.1'>CMF3 Changelog v2.1.1.61 => v2.1.1.62</t>
Reverted codebase back to v2.1.1.58

<t size='1.05' color='#00aa22'>Added</t>
	• Added function to set a random loadout for a unit using a specified loadoutfile in 3den and zeus
	• Added function to set a crate loadout for a crate using a specified logistics file in 3den and zeus
	• Added a script log viewer to the CMF menu
	• Added `PATHTO` family of macros

<t size='1.05' color='#009eaa'>Changed</t>
	• Changed how ui elements are included. it now uses a master include file in the ui directory
	• Changed how zeus/curator modules are registered
	• Renamed all curator functions to reflect the change
	• Changed so logistics crates will always be carryable / draggable regardless of weight

<t size='1.05' color='#009eaa'>Fixed</t>
	• Fixed bug where vehicle rallypoints were placeable for everyone
"
// @TODO: Use markdown parser with a custom stylesheet mimicking github markdown
/*
	TEMPLATES

	ADDED
	<t size='1.05' color='#00aa22'>Added</t>

	CHANGED
	<t size='1.05' color='#009eaa'>Changed</t>

	FIXED
	<t size='1.05' color='#009eaa'>Fixed</t>

	REMOVED
	<t size='1.05' color='#aa0027'>Removed</t>
*/
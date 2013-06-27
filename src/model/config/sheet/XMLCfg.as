package model.config.sheet
{
	public class XMLCfg
	{
		[Embed(source="assets/xml/gamecfg.xml", mimeType='application/octet-stream')]
		public static var GamecfgXML:Class;
		[Embed(source="assets/xml/loadcfg.xml", mimeType='application/octet-stream')]
		public static var LoadcfgXML:Class; 
		[Embed(source="assets/xml/module.xml", mimeType='application/octet-stream')]
		public static var ModuleXML:Class;
		[Embed(source="assets/xml/asset.xml", mimeType='application/octet-stream')]
		public static var AssetXML:Class;
		[Embed(source="assets/xml/sheet.xml", mimeType='application/octet-stream')]
		public static var SheetXML:Class; 
			
	}
}
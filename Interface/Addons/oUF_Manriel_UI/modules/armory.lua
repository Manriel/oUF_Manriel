local parent, ns = ...
local UI = ns.ManrielUI
local arStrings = UI.localeStrings

--	Armory link on right click player

local arRealms = {
	us = {},
	eu = {},
	kr = {},
	tw = {},
	cn = {},
};

arRealms['us']['Aegwynn'] = {locale = [[en_US]],name = [[aegwynn]]};
arRealms['us']['AeriePeak'] = {locale = [[en_US]],name = [[aerie-peak]]};
arRealms['us']['Agamaggan'] = {locale = [[en_US]],name = [[agamaggan]]};
arRealms['us']['Aggramar'] = {locale = [[en_US]],name = [[aggramar]]};
arRealms['us']['Akama'] = {locale = [[en_US]],name = [[akama]]};
arRealms['us']['Alexstrasza'] = {locale = [[en_US]],name = [[alexstrasza]]};
arRealms['us']['Alleria'] = {locale = [[en_US]],name = [[alleria]]};
arRealms['us']['AltarofStorms'] = {locale = [[en_US]],name = [[altar-of-storms]]};
arRealms['us']['AlteracMountains'] = {locale = [[en_US]],name = [[alterac-mountains]]};
arRealms['us']['AmanThul'] = {locale = [[en_US]],name = [[amanthul]]};
arRealms['us']['Andorhal'] = {locale = [[en_US]],name = [[andorhal]]};
arRealms['us']['Anetheron'] = {locale = [[en_US]],name = [[anetheron]]};
arRealms['us']['Antonidas'] = {locale = [[en_US]],name = [[antonidas]]};
arRealms['us']['Anubarak'] = {locale = [[en_US]],name = [[anubarak]]};
arRealms['us']['Anvilmar'] = {locale = [[en_US]],name = [[anvilmar]]};
arRealms['us']['Arathor'] = {locale = [[en_US]],name = [[arathor]]};
arRealms['us']['Archimonde'] = {locale = [[en_US]],name = [[archimonde]]};
arRealms['us']['Area52'] = {locale = [[en_US]],name = [[area-52]]};
arRealms['us']['ArgentDawn'] = {locale = [[en_US]],name = [[argent-dawn]]};
arRealms['us']['Arthas'] = {locale = [[en_US]],name = [[arthas]]};
arRealms['us']['Arygos'] = {locale = [[en_US]],name = [[arygos]]};
arRealms['us']['Auchindoun'] = {locale = [[en_US]],name = [[auchindoun]]};
arRealms['us']['Azgalor'] = {locale = [[en_US]],name = [[azgalor]]};
arRealms['us']['AzjolNerub'] = {locale = [[en_US]],name = [[azjolnerub]]};
arRealms['us']['Azralon'] = {locale = [[pt_BR]],name = [[azralon]]};
arRealms['us']['Azshara'] = {locale = [[en_US]],name = [[azshara]]};
arRealms['us']['Azuremyst'] = {locale = [[en_US]],name = [[azuremyst]]};
arRealms['us']['Baelgun'] = {locale = [[en_US]],name = [[baelgun]]};
arRealms['us']['Balnazzar'] = {locale = [[en_US]],name = [[balnazzar]]};
arRealms['us']['Barthilas'] = {locale = [[en_US]],name = [[barthilas]]};
arRealms['us']['BlackDragonflight'] = {locale = [[en_US]],name = [[black-dragonflight]]};
arRealms['us']['Blackhand'] = {locale = [[en_US]],name = [[blackhand]]};
arRealms['us']['Blackrock'] = {locale = [[en_US]],name = [[blackrock]]};
arRealms['us']['BlackwaterRaiders'] = {locale = [[en_US]],name = [[blackwater-raiders]]};
arRealms['us']['BlackwingLair'] = {locale = [[en_US]],name = [[blackwing-lair]]};
arRealms['us']['BladesEdge'] = {locale = [[en_US]],name = [[blades-edge]]};
arRealms['us']['Bladefist'] = {locale = [[en_US]],name = [[bladefist]]};
arRealms['us']['BleedingHollow'] = {locale = [[en_US]],name = [[bleeding-hollow]]};
arRealms['us']['BloodFurnace'] = {locale = [[en_US]],name = [[blood-furnace]]};
arRealms['us']['Bloodhoof'] = {locale = [[en_US]],name = [[bloodhoof]]};
arRealms['us']['Bloodscalp'] = {locale = [[en_US]],name = [[bloodscalp]]};
arRealms['us']['Bonechewer'] = {locale = [[en_US]],name = [[bonechewer]]};
arRealms['us']['BoreanTundra'] = {locale = [[en_US]],name = [[borean-tundra]]};
arRealms['us']['Boulderfist'] = {locale = [[en_US]],name = [[boulderfist]]};
arRealms['us']['Bronzebeard'] = {locale = [[en_US]],name = [[bronzebeard]]};
arRealms['us']['BurningBlade'] = {locale = [[en_US]],name = [[burning-blade]]};
arRealms['us']['BurningLegion'] = {locale = [[en_US]],name = [[burning-legion]]};
arRealms['us']['Caelestrasz'] = {locale = [[en_US]],name = [[caelestrasz]]};
arRealms['us']['Cairne'] = {locale = [[en_US]],name = [[cairne]]};
arRealms['us']['CenarionCircle'] = {locale = [[en_US]],name = [[cenarion-circle]]};
arRealms['us']['Cenarius'] = {locale = [[en_US]],name = [[cenarius]]};
arRealms['us']['Chogall'] = {locale = [[en_US]],name = [[chogall]]};
arRealms['us']['Chromaggus'] = {locale = [[en_US]],name = [[chromaggus]]};
arRealms['us']['Coilfang'] = {locale = [[en_US]],name = [[coilfang]]};
arRealms['us']['Crushridge'] = {locale = [[en_US]],name = [[crushridge]]};
arRealms['us']['Daggerspine'] = {locale = [[en_US]],name = [[daggerspine]]};
arRealms['us']['Dalaran'] = {locale = [[en_US]],name = [[dalaran]]};
arRealms['us']['Dalvengyr'] = {locale = [[en_US]],name = [[dalvengyr]]};
arRealms['us']['DarkIron'] = {locale = [[en_US]],name = [[dark-iron]]};
arRealms['us']['Darkspear'] = {locale = [[en_US]],name = [[darkspear]]};
arRealms['us']['Darrowmere'] = {locale = [[en_US]],name = [[darrowmere]]};
arRealms['us']['DathRemar'] = {locale = [[en_US]],name = [[dathremar]]};
arRealms['us']['Dawnbringer'] = {locale = [[en_US]],name = [[dawnbringer]]};
arRealms['us']['Deathwing'] = {locale = [[en_US]],name = [[deathwing]]};
arRealms['us']['DemonSoul'] = {locale = [[en_US]],name = [[demon-soul]]};
arRealms['us']['Dentarg'] = {locale = [[en_US]],name = [[dentarg]]};
arRealms['us']['Destromath'] = {locale = [[en_US]],name = [[destromath]]};
arRealms['us']['Dethecus'] = {locale = [[en_US]],name = [[dethecus]]};
arRealms['us']['Detheroc'] = {locale = [[en_US]],name = [[detheroc]]};
arRealms['us']['Doomhammer'] = {locale = [[en_US]],name = [[doomhammer]]};
arRealms['us']['Draenor'] = {locale = [[en_US]],name = [[draenor]]};
arRealms['us']['Dragonblight'] = {locale = [[en_US]],name = [[dragonblight]]};
arRealms['us']['Dragonmaw'] = {locale = [[en_US]],name = [[dragonmaw]]};
arRealms['us']['DrakTharon'] = {locale = [[en_US]],name = [[draktharon]]};
arRealms['us']['Drakthul'] = {locale = [[en_US]],name = [[drakthul]]};
arRealms['us']['Draka'] = {locale = [[en_US]],name = [[draka]]};
arRealms['us']['Drakkari'] = {locale = [[es_MX]],name = [[drakkari]]};
arRealms['us']['Dreadmaul'] = {locale = [[en_US]],name = [[dreadmaul]]};
arRealms['us']['Drenden'] = {locale = [[en_US]],name = [[drenden]]};
arRealms['us']['Dunemaul'] = {locale = [[en_US]],name = [[dunemaul]]};
arRealms['us']['Durotan'] = {locale = [[en_US]],name = [[durotan]]};
arRealms['us']['Duskwood'] = {locale = [[en_US]],name = [[duskwood]]};
arRealms['us']['EarthenRing'] = {locale = [[en_US]],name = [[earthen-ring]]};
arRealms['us']['EchoIsles'] = {locale = [[en_US]],name = [[echo-isles]]};
arRealms['us']['Eitrigg'] = {locale = [[en_US]],name = [[eitrigg]]};
arRealms['us']['EldreThalas'] = {locale = [[en_US]],name = [[eldrethalas]]};
arRealms['us']['Elune'] = {locale = [[en_US]],name = [[elune]]};
arRealms['us']['EmeraldDream'] = {locale = [[en_US]],name = [[emerald-dream]]};
arRealms['us']['Eonar'] = {locale = [[en_US]],name = [[eonar]]};
arRealms['us']['Eredar'] = {locale = [[en_US]],name = [[eredar]]};
arRealms['us']['Executus'] = {locale = [[en_US]],name = [[executus]]};
arRealms['us']['Exodar'] = {locale = [[en_US]],name = [[exodar]]};
arRealms['us']['Farstriders'] = {locale = [[en_US]],name = [[farstriders]]};
arRealms['us']['Feathermoon'] = {locale = [[en_US]],name = [[feathermoon]]};
arRealms['us']['Fenris'] = {locale = [[en_US]],name = [[fenris]]};
arRealms['us']['Firetree'] = {locale = [[en_US]],name = [[firetree]]};
arRealms['us']['Fizzcrank'] = {locale = [[en_US]],name = [[fizzcrank]]};
arRealms['us']['Frostmane'] = {locale = [[en_US]],name = [[frostmane]]};
arRealms['us']['Frostmourne'] = {locale = [[en_US]],name = [[frostmourne]]};
arRealms['us']['Frostwolf'] = {locale = [[en_US]],name = [[frostwolf]]};
arRealms['us']['Galakrond'] = {locale = [[en_US]],name = [[galakrond]]};
arRealms['us']['Gallywix'] = {locale = [[pt_BR]],name = [[gallywix]]};
arRealms['us']['Garithos'] = {locale = [[en_US]],name = [[garithos]]};
arRealms['us']['Garona'] = {locale = [[en_US]],name = [[garona]]};
arRealms['us']['Garrosh'] = {locale = [[en_US]],name = [[garrosh]]};
arRealms['us']['Ghostlands'] = {locale = [[en_US]],name = [[ghostlands]]};
arRealms['us']['Gilneas'] = {locale = [[en_US]],name = [[gilneas]]};
arRealms['us']['Gnomeregan'] = {locale = [[en_US]],name = [[gnomeregan]]};
arRealms['us']['Goldrinn'] = {locale = [[pt_BR]],name = [[goldrinn]]};
arRealms['us']['Gorefiend'] = {locale = [[en_US]],name = [[gorefiend]]};
arRealms['us']['Gorgonnash'] = {locale = [[en_US]],name = [[gorgonnash]]};
arRealms['us']['Greymane'] = {locale = [[en_US]],name = [[greymane]]};
arRealms['us']['GrizzlyHills'] = {locale = [[en_US]],name = [[grizzly-hills]]};
arRealms['us']['Guldan'] = {locale = [[en_US]],name = [[guldan]]};
arRealms['us']['Gundrak'] = {locale = [[en_US]],name = [[gundrak]]};
arRealms['us']['Gurubashi'] = {locale = [[en_US]],name = [[gurubashi]]};
arRealms['us']['Hakkar'] = {locale = [[en_US]],name = [[hakkar]]};
arRealms['us']['Haomarush'] = {locale = [[en_US]],name = [[haomarush]]};
arRealms['us']['Hellscream'] = {locale = [[en_US]],name = [[hellscream]]};
arRealms['us']['Hydraxis'] = {locale = [[en_US]],name = [[hydraxis]]};
arRealms['us']['Hyjal'] = {locale = [[en_US]],name = [[hyjal]]};
arRealms['us']['Icecrown'] = {locale = [[en_US]],name = [[icecrown]]};
arRealms['us']['Illidan'] = {locale = [[en_US]],name = [[illidan]]};
arRealms['us']['Jaedenar'] = {locale = [[en_US]],name = [[jaedenar]]};
arRealms['us']['JubeiThos'] = {locale = [[en_US]],name = [[jubeithos]]};
arRealms['us']['Kaelthas'] = {locale = [[en_US]],name = [[kaelthas]]};
arRealms['us']['Kalecgos'] = {locale = [[en_US]],name = [[kalecgos]]};
arRealms['us']['Kargath'] = {locale = [[en_US]],name = [[kargath]]};
arRealms['us']['KelThuzad'] = {locale = [[en_US]],name = [[kelthuzad]]};
arRealms['us']['Khadgar'] = {locale = [[en_US]],name = [[khadgar]]};
arRealms['us']['KhazModan'] = {locale = [[en_US]],name = [[khaz-modan]]};
arRealms['us']['Khazgoroth'] = {locale = [[en_US]],name = [[khazgoroth]]};
arRealms['us']['Kiljaeden'] = {locale = [[en_US]],name = [[kiljaeden]]};
arRealms['us']['Kilrogg'] = {locale = [[en_US]],name = [[kilrogg]]};
arRealms['us']['KirinTor'] = {locale = [[en_US]],name = [[kirin-tor]]};
arRealms['us']['Korgath'] = {locale = [[en_US]],name = [[korgath]]};
arRealms['us']['Korialstrasz'] = {locale = [[en_US]],name = [[korialstrasz]]};
arRealms['us']['KulTiras'] = {locale = [[en_US]],name = [[kul-tiras]]};
arRealms['us']['LaughingSkull'] = {locale = [[en_US]],name = [[laughing-skull]]};
arRealms['us']['Lethon'] = {locale = [[en_US]],name = [[lethon]]};
arRealms['us']['Lightbringer'] = {locale = [[en_US]],name = [[lightbringer]]};
arRealms['us']['LightningsBlade'] = {locale = [[en_US]],name = [[lightnings-blade]]};
arRealms['us']['Lightninghoof'] = {locale = [[en_US]],name = [[lightninghoof]]};
arRealms['us']['Llane'] = {locale = [[en_US]],name = [[llane]]};
arRealms['us']['Lothar'] = {locale = [[en_US]],name = [[lothar]]};
arRealms['us']['Madoran'] = {locale = [[en_US]],name = [[madoran]]};
arRealms['us']['Maelstrom'] = {locale = [[en_US]],name = [[maelstrom]]};
arRealms['us']['Magtheridon'] = {locale = [[en_US]],name = [[magtheridon]]};
arRealms['us']['Maiev'] = {locale = [[en_US]],name = [[maiev]]};
arRealms['us']['MalGanis'] = {locale = [[en_US]],name = [[malganis]]};
arRealms['us']['Malfurion'] = {locale = [[en_US]],name = [[malfurion]]};
arRealms['us']['Malorne'] = {locale = [[en_US]],name = [[malorne]]};
arRealms['us']['Malygos'] = {locale = [[en_US]],name = [[malygos]]};
arRealms['us']['Mannoroth'] = {locale = [[en_US]],name = [[mannoroth]]};
arRealms['us']['Medivh'] = {locale = [[en_US]],name = [[medivh]]};
arRealms['us']['Misha'] = {locale = [[en_US]],name = [[misha]]};
arRealms['us']['MokNathal'] = {locale = [[en_US]],name = [[moknathal]]};
arRealms['us']['MoonGuard'] = {locale = [[en_US]],name = [[moon-guard]]};
arRealms['us']['Moonrunner'] = {locale = [[en_US]],name = [[moonrunner]]};
arRealms['us']['Mugthol'] = {locale = [[en_US]],name = [[mugthol]]};
arRealms['us']['Muradin'] = {locale = [[en_US]],name = [[muradin]]};
arRealms['us']['Nagrand'] = {locale = [[en_US]],name = [[nagrand]]};
arRealms['us']['Nathrezim'] = {locale = [[en_US]],name = [[nathrezim]]};
arRealms['us']['Nazgrel'] = {locale = [[en_US]],name = [[nazgrel]]};
arRealms['us']['Nazjatar'] = {locale = [[en_US]],name = [[nazjatar]]};
arRealms['us']['Nemesis'] = {locale = [[pt_BR]],name = [[nemesis]]};
arRealms['us']['Nerzhul'] = {locale = [[en_US]],name = [[nerzhul]]};
arRealms['us']['Nesingwary'] = {locale = [[en_US]],name = [[nesingwary]]};
arRealms['us']['Nordrassil'] = {locale = [[en_US]],name = [[nordrassil]]};
arRealms['us']['Norgannon'] = {locale = [[en_US]],name = [[norgannon]]};
arRealms['us']['Onyxia'] = {locale = [[en_US]],name = [[onyxia]]};
arRealms['us']['Perenolde'] = {locale = [[en_US]],name = [[perenolde]]};
arRealms['us']['Proudmoore'] = {locale = [[en_US]],name = [[proudmoore]]};
arRealms['us']['QuelThalas'] = {locale = [[es_MX]],name = [[quelthalas]]};
arRealms['us']['Queldorei'] = {locale = [[en_US]],name = [[queldorei]]};
arRealms['us']['Ragnaros'] = {locale = [[es_MX]],name = [[ragnaros]]};
arRealms['us']['Ravencrest'] = {locale = [[en_US]],name = [[ravencrest]]};
arRealms['us']['Ravenholdt'] = {locale = [[en_US]],name = [[ravenholdt]]};
arRealms['us']['Rexxar'] = {locale = [[en_US]],name = [[rexxar]]};
arRealms['us']['Rivendare'] = {locale = [[en_US]],name = [[rivendare]]};
arRealms['us']['Runetotem'] = {locale = [[en_US]],name = [[runetotem]]};
arRealms['us']['Sargeras'] = {locale = [[en_US]],name = [[sargeras]]};
arRealms['us']['Saurfang'] = {locale = [[en_US]],name = [[saurfang]]};
arRealms['us']['ScarletCrusade'] = {locale = [[en_US]],name = [[scarlet-crusade]]};
arRealms['us']['Scilla'] = {locale = [[en_US]],name = [[scilla]]};
arRealms['us']['Senjin'] = {locale = [[en_US]],name = [[senjin]]};
arRealms['us']['Sentinels'] = {locale = [[en_US]],name = [[sentinels]]};
arRealms['us']['ShadowCouncil'] = {locale = [[en_US]],name = [[shadow-council]]};
arRealms['us']['Shadowmoon'] = {locale = [[en_US]],name = [[shadowmoon]]};
arRealms['us']['Shadowsong'] = {locale = [[en_US]],name = [[shadowsong]]};
arRealms['us']['Shandris'] = {locale = [[en_US]],name = [[shandris]]};
arRealms['us']['ShatteredHalls'] = {locale = [[en_US]],name = [[shattered-halls]]};
arRealms['us']['ShatteredHand'] = {locale = [[en_US]],name = [[shattered-hand]]};
arRealms['us']['Shuhalo'] = {locale = [[en_US]],name = [[shuhalo]]};
arRealms['us']['SilverHand'] = {locale = [[en_US]],name = [[silver-hand]]};
arRealms['us']['Silvermoon'] = {locale = [[en_US]],name = [[silvermoon]]};
arRealms['us']['SistersofElune'] = {locale = [[en_US]],name = [[sisters-of-elune]]};
arRealms['us']['Skullcrusher'] = {locale = [[en_US]],name = [[skullcrusher]]};
arRealms['us']['Skywall'] = {locale = [[en_US]],name = [[skywall]]};
arRealms['us']['Smolderthorn'] = {locale = [[en_US]],name = [[smolderthorn]]};
arRealms['us']['Spinebreaker'] = {locale = [[en_US]],name = [[spinebreaker]]};
arRealms['us']['Spirestone'] = {locale = [[en_US]],name = [[spirestone]]};
arRealms['us']['Staghelm'] = {locale = [[en_US]],name = [[staghelm]]};
arRealms['us']['SteamwheedleCartel'] = {locale = [[en_US]],name = [[steamwheedle-cartel]]};
arRealms['us']['Stonemaul'] = {locale = [[en_US]],name = [[stonemaul]]};
arRealms['us']['Stormrage'] = {locale = [[en_US]],name = [[stormrage]]};
arRealms['us']['Stormreaver'] = {locale = [[en_US]],name = [[stormreaver]]};
arRealms['us']['Stormscale'] = {locale = [[en_US]],name = [[stormscale]]};
arRealms['us']['Suramar'] = {locale = [[en_US]],name = [[suramar]]};
arRealms['us']['Tanaris'] = {locale = [[en_US]],name = [[tanaris]]};
arRealms['us']['Terenas'] = {locale = [[en_US]],name = [[terenas]]};
arRealms['us']['Terokkar'] = {locale = [[en_US]],name = [[terokkar]]};
arRealms['us']['Thaurissan'] = {locale = [[en_US]],name = [[thaurissan]]};
arRealms['us']['TheForgottenCoast'] = {locale = [[en_US]],name = [[the-forgotten-coast]]};
arRealms['us']['TheScryers'] = {locale = [[en_US]],name = [[the-scryers]]};
arRealms['us']['TheUnderbog'] = {locale = [[en_US]],name = [[the-underbog]]};
arRealms['us']['TheVentureCo'] = {locale = [[en_US]],name = [[the-venture-co]]};
arRealms['us']['ThoriumBrotherhood'] = {locale = [[en_US]],name = [[thorium-brotherhood]]};
arRealms['us']['Thrall'] = {locale = [[en_US]],name = [[thrall]]};
arRealms['us']['Thunderhorn'] = {locale = [[en_US]],name = [[thunderhorn]]};
arRealms['us']['Thunderlord'] = {locale = [[en_US]],name = [[thunderlord]]};
arRealms['us']['Tichondrius'] = {locale = [[en_US]],name = [[tichondrius]]};
arRealms['us']['TolBarad'] = {locale = [[pt_BR]],name = [[tol-barad]]};
arRealms['us']['Tortheldrin'] = {locale = [[en_US]],name = [[tortheldrin]]};
arRealms['us']['Trollbane'] = {locale = [[en_US]],name = [[trollbane]]};
arRealms['us']['Turalyon'] = {locale = [[en_US]],name = [[turalyon]]};
arRealms['us']['TwistingNether'] = {locale = [[en_US]],name = [[twisting-nether]]};
arRealms['us']['Uldaman'] = {locale = [[en_US]],name = [[uldaman]]};
arRealms['us']['Uldum'] = {locale = [[en_US]],name = [[uldum]]};
arRealms['us']['Undermine'] = {locale = [[en_US]],name = [[undermine]]};
arRealms['us']['Ursin'] = {locale = [[en_US]],name = [[ursin]]};
arRealms['us']['Uther'] = {locale = [[en_US]],name = [[uther]]};
arRealms['us']['Vashj'] = {locale = [[en_US]],name = [[vashj]]};
arRealms['us']['Veknilash'] = {locale = [[en_US]],name = [[veknilash]]};
arRealms['us']['Velen'] = {locale = [[en_US]],name = [[velen]]};
arRealms['us']['Warsong'] = {locale = [[en_US]],name = [[warsong]]};
arRealms['us']['Whisperwind'] = {locale = [[en_US]],name = [[whisperwind]]};
arRealms['us']['Wildhammer'] = {locale = [[en_US]],name = [[wildhammer]]};
arRealms['us']['Windrunner'] = {locale = [[en_US]],name = [[windrunner]]};
arRealms['us']['Winterhoof'] = {locale = [[en_US]],name = [[winterhoof]]};
arRealms['us']['WyrmrestAccord'] = {locale = [[en_US]],name = [[wyrmrest-accord]]};
arRealms['us']['Ysera'] = {locale = [[en_US]],name = [[ysera]]};
arRealms['us']['Ysondre'] = {locale = [[en_US]],name = [[ysondre]]};
arRealms['us']['Zangarmarsh'] = {locale = [[en_US]],name = [[zangarmarsh]]};
arRealms['us']['Zuljin'] = {locale = [[en_US]],name = [[zuljin]]};
arRealms['us']['Zuluhed'] = {locale = [[en_US]],name = [[zuluhed]]};

arRealms['eu']['Aegwynn'] = {locale = [[de_DE]],name = [[aegwynn]]};
arRealms['eu']['AeriePeak'] = {locale = [[en_GB]],name = [[aerie-peak]]};
arRealms['eu']['Agamaggan'] = {locale = [[en_GB]],name = [[agamaggan]]};
arRealms['eu']['AggraPortuguês'] = {locale = [[pt_BR]],name = [[aggra-portugues]]};
arRealms['eu']['Aggramar'] = {locale = [[en_GB]],name = [[aggramar]]};
arRealms['eu']['AhnQiraj'] = {locale = [[en_GB]],name = [[ahnqiraj]]};
arRealms['eu']['AlAkir'] = {locale = [[en_GB]],name = [[alakir]]};
arRealms['eu']['Alexstrasza'] = {locale = [[de_DE]],name = [[alexstrasza]]};
arRealms['eu']['Alleria'] = {locale = [[de_DE]],name = [[alleria]]};
arRealms['eu']['Alonsus'] = {locale = [[en_GB]],name = [[alonsus]]};
arRealms['eu']['AmanThul'] = {locale = [[de_DE]],name = [[amanthul]]};
arRealms['eu']['Ambossar'] = {locale = [[de_DE]],name = [[ambossar]]};
arRealms['eu']['Anachronos'] = {locale = [[en_GB]],name = [[anachronos]]};
arRealms['eu']['Anetheron'] = {locale = [[de_DE]],name = [[anetheron]]};
arRealms['eu']['Antonidas'] = {locale = [[de_DE]],name = [[antonidas]]};
arRealms['eu']['Anubarak'] = {locale = [[de_DE]],name = [[anubarak]]};
arRealms['eu']['Arakarahm'] = {locale = [[fr_FR]],name = [[arakarahm]]};
arRealms['eu']['Arathi'] = {locale = [[fr_FR]],name = [[arathi]]};
arRealms['eu']['Arathor'] = {locale = [[en_GB]],name = [[arathor]]};
arRealms['eu']['Archimonde'] = {locale = [[fr_FR]],name = [[archimonde]]};
arRealms['eu']['Area52'] = {locale = [[de_DE]],name = [[area-52]]};
arRealms['eu']['ArgentDawn'] = {locale = [[en_GB]],name = [[argent-dawn]]};
arRealms['eu']['Arthas'] = {locale = [[de_DE]],name = [[arthas]]};
arRealms['eu']['Arygos'] = {locale = [[de_DE]],name = [[arygos]]};
arRealms['eu']['Aszune'] = {locale = [[en_GB]],name = [[aszune]]};
arRealms['eu']['Auchindoun'] = {locale = [[en_GB]],name = [[auchindoun]]};
arRealms['eu']['AzjolNerub'] = {locale = [[en_GB]],name = [[azjolnerub]]};
arRealms['eu']['Azshara'] = {locale = [[de_DE]],name = [[azshara]]};
arRealms['eu']['Azuremyst'] = {locale = [[en_GB]],name = [[azuremyst]]};
arRealms['eu']['Baelgun'] = {locale = [[de_DE]],name = [[baelgun]]};
arRealms['eu']['Balnazzar'] = {locale = [[en_GB]],name = [[balnazzar]]};
arRealms['eu']['Blackhand'] = {locale = [[de_DE]],name = [[blackhand]]};
arRealms['eu']['Blackmoore'] = {locale = [[de_DE]],name = [[blackmoore]]};
arRealms['eu']['Blackrock'] = {locale = [[de_DE]],name = [[blackrock]]};
arRealms['eu']['BladesEdge'] = {locale = [[en_GB]],name = [[blades-edge]]};
arRealms['eu']['Bladefist'] = {locale = [[en_GB]],name = [[bladefist]]};
arRealms['eu']['Bloodfeather'] = {locale = [[en_GB]],name = [[bloodfeather]]};
arRealms['eu']['Bloodhoof'] = {locale = [[en_GB]],name = [[bloodhoof]]};
arRealms['eu']['Bloodscalp'] = {locale = [[en_GB]],name = [[bloodscalp]]};
arRealms['eu']['Blutkessel'] = {locale = [[de_DE]],name = [[blutkessel]]};
arRealms['eu']['Boulderfist'] = {locale = [[en_GB]],name = [[boulderfist]]};
arRealms['eu']['BronzeDragonflight'] = {locale = [[en_GB]],name = [[bronze-dragonflight]]};
arRealms['eu']['Bronzebeard'] = {locale = [[en_GB]],name = [[bronzebeard]]};
arRealms['eu']['BurningBlade'] = {locale = [[en_GB]],name = [[burning-blade]]};
arRealms['eu']['BurningSteppes'] = {locale = [[en_GB]],name = [[burning-steppes]]};
arRealms['eu']['CThun'] = {locale = [[es_ES]],name = [[cthun]]};
arRealms['eu']['ChamberofAspects'] = {locale = [[en_GB]],name = [[chamber-of-aspects]]};
arRealms['eu']['Chantséternels'] = {locale = [[fr_FR]],name = [[chants-eternels]]};
arRealms['eu']['Chogall'] = {locale = [[fr_FR]],name = [[chogall]]};
arRealms['eu']['Chromaggus'] = {locale = [[en_GB]],name = [[chromaggus]]};
arRealms['eu']['ConfrérieduThorium'] = {locale = [[fr_FR]],name = [[confrerie-du-thorium]]};
arRealms['eu']['ConseildesOmbres'] = {locale = [[fr_FR]],name = [[conseil-des-ombres]]};
arRealms['eu']['Crushridge'] = {locale = [[en_GB]],name = [[crushridge]]};
arRealms['eu']['CultedelaRivenoire'] = {locale = [[fr_FR]],name = [[culte-de-la-rive-noire]]};
arRealms['eu']['Daggerspine'] = {locale = [[en_GB]],name = [[daggerspine]]};
arRealms['eu']['Dalaran'] = {locale = [[fr_FR]],name = [[dalaran]]};
arRealms['eu']['Dalvengyr'] = {locale = [[de_DE]],name = [[dalvengyr]]};
arRealms['eu']['DarkmoonFaire'] = {locale = [[en_GB]],name = [[darkmoon-faire]]};
arRealms['eu']['Darksorrow'] = {locale = [[en_GB]],name = [[darksorrow]]};
arRealms['eu']['Darkspear'] = {locale = [[en_GB]],name = [[darkspear]]};
arRealms['eu']['DasKonsortium'] = {locale = [[de_DE]],name = [[das-konsortium]]};
arRealms['eu']['DasSyndikat'] = {locale = [[de_DE]],name = [[das-syndikat]]};
arRealms['eu']['Deathwing'] = {locale = [[en_GB]],name = [[deathwing]]};
arRealms['eu']['DefiasBrotherhood'] = {locale = [[en_GB]],name = [[defias-brotherhood]]};
arRealms['eu']['Dentarg'] = {locale = [[en_GB]],name = [[dentarg]]};
arRealms['eu']['DerMithrilorden'] = {locale = [[de_DE]],name = [[der-mithrilorden]]};
arRealms['eu']['DerRatvonDalaran'] = {locale = [[de_DE]],name = [[der-rat-von-dalaran]]};
arRealms['eu']['DerabyssischeRat'] = {locale = [[de_DE]],name = [[der-abyssische-rat]]};
arRealms['eu']['Destromath'] = {locale = [[de_DE]],name = [[destromath]]};
arRealms['eu']['Dethecus'] = {locale = [[de_DE]],name = [[dethecus]]};
arRealms['eu']['DieAldor'] = {locale = [[de_DE]],name = [[die-aldor]]};
arRealms['eu']['DieArguswacht'] = {locale = [[de_DE]],name = [[die-arguswacht]]};
arRealms['eu']['DieNachtwache'] = {locale = [[de_DE]],name = [[die-nachtwache]]};
arRealms['eu']['DieSilberneHand'] = {locale = [[de_DE]],name = [[die-silberne-hand]]};
arRealms['eu']['DieTodeskrallen'] = {locale = [[de_DE]],name = [[die-todeskrallen]]};
arRealms['eu']['DieewigeWacht'] = {locale = [[de_DE]],name = [[die-ewige-wacht]]};
arRealms['eu']['Doomhammer'] = {locale = [[en_GB]],name = [[doomhammer]]};
arRealms['eu']['Draenor'] = {locale = [[en_GB]],name = [[draenor]]};
arRealms['eu']['Dragonblight'] = {locale = [[en_GB]],name = [[dragonblight]]};
arRealms['eu']['Dragonmaw'] = {locale = [[en_GB]],name = [[dragonmaw]]};
arRealms['eu']['Drakthul'] = {locale = [[en_GB]],name = [[drakthul]]};
arRealms['eu']['DrekThar'] = {locale = [[fr_FR]],name = [[drekthar]]};
arRealms['eu']['DunModr'] = {locale = [[es_ES]],name = [[dun-modr]]};
arRealms['eu']['DunMorogh'] = {locale = [[de_DE]],name = [[dun-morogh]]};
arRealms['eu']['Dunemaul'] = {locale = [[en_GB]],name = [[dunemaul]]};
arRealms['eu']['Durotan'] = {locale = [[de_DE]],name = [[durotan]]};
arRealms['eu']['EarthenRing'] = {locale = [[en_GB]],name = [[earthen-ring]]};
arRealms['eu']['Echsenkessel'] = {locale = [[de_DE]],name = [[echsenkessel]]};
arRealms['eu']['Eitrigg'] = {locale = [[fr_FR]],name = [[eitrigg]]};
arRealms['eu']['EldreThalas'] = {locale = [[fr_FR]],name = [[eldrethalas]]};
arRealms['eu']['Elune'] = {locale = [[fr_FR]],name = [[elune]]};
arRealms['eu']['EmeraldDream'] = {locale = [[en_GB]],name = [[emerald-dream]]};
arRealms['eu']['Emeriss'] = {locale = [[en_GB]],name = [[emeriss]]};
arRealms['eu']['Eonar'] = {locale = [[en_GB]],name = [[eonar]]};
arRealms['eu']['Eredar'] = {locale = [[de_DE]],name = [[eredar]]};
arRealms['eu']['Executus'] = {locale = [[en_GB]],name = [[executus]]};
arRealms['eu']['Exodar'] = {locale = [[es_ES]],name = [[exodar]]};
arRealms['eu']['FestungderStürme'] = {locale = [[de_DE]],name = [[festung-der-sturme]]};
arRealms['eu']['Forscherliga'] = {locale = [[de_DE]],name = [[forscherliga]]};
arRealms['eu']['Frostmane'] = {locale = [[en_GB]],name = [[frostmane]]};
arRealms['eu']['Frostmourne'] = {locale = [[de_DE]],name = [[frostmourne]]};
arRealms['eu']['Frostwhisper'] = {locale = [[en_GB]],name = [[frostwhisper]]};
arRealms['eu']['Frostwolf'] = {locale = [[de_DE]],name = [[frostwolf]]};
arRealms['eu']['Garona'] = {locale = [[fr_FR]],name = [[garona]]};
arRealms['eu']['Garrosh'] = {locale = [[de_DE]],name = [[garrosh]]};
arRealms['eu']['Genjuros'] = {locale = [[en_GB]],name = [[genjuros]]};
arRealms['eu']['Ghostlands'] = {locale = [[en_GB]],name = [[ghostlands]]};
arRealms['eu']['Gilneas'] = {locale = [[de_DE]],name = [[gilneas]]};
arRealms['eu']['Gorgonnash'] = {locale = [[de_DE]],name = [[gorgonnash]]};
arRealms['eu']['GrimBatol'] = {locale = [[en_GB]],name = [[grim-batol]]};
arRealms['eu']['Guldan'] = {locale = [[de_DE]],name = [[guldan]]};
arRealms['eu']['Hakkar'] = {locale = [[en_GB]],name = [[hakkar]]};
arRealms['eu']['Haomarush'] = {locale = [[en_GB]],name = [[haomarush]]};
arRealms['eu']['Hellfire'] = {locale = [[en_GB]],name = [[hellfire]]};
arRealms['eu']['Hellscream'] = {locale = [[en_GB]],name = [[hellscream]]};
arRealms['eu']['Hyjal'] = {locale = [[fr_FR]],name = [[hyjal]]};
arRealms['eu']['Illidan'] = {locale = [[fr_FR]],name = [[illidan]]};
arRealms['eu']['Jaedenar'] = {locale = [[en_GB]],name = [[jaedenar]]};
arRealms['eu']['Kaelthas'] = {locale = [[fr_FR]],name = [[kaelthas]]};
arRealms['eu']['Karazhan'] = {locale = [[en_GB]],name = [[karazhan]]};
arRealms['eu']['Kargath'] = {locale = [[de_DE]],name = [[kargath]]};
arRealms['eu']['Kazzak'] = {locale = [[en_GB]],name = [[kazzak]]};
arRealms['eu']['KelThuzad'] = {locale = [[de_DE]],name = [[kelthuzad]]};
arRealms['eu']['Khadgar'] = {locale = [[en_GB]],name = [[khadgar]]};
arRealms['eu']['KhazModan'] = {locale = [[fr_FR]],name = [[khaz-modan]]};
arRealms['eu']['Khazgoroth'] = {locale = [[de_DE]],name = [[khazgoroth]]};
arRealms['eu']['Kiljaeden'] = {locale = [[de_DE]],name = [[kiljaeden]]};
arRealms['eu']['Kilrogg'] = {locale = [[en_GB]],name = [[kilrogg]]};
arRealms['eu']['KirinTor'] = {locale = [[fr_FR]],name = [[kirin-tor]]};
arRealms['eu']['Korgall'] = {locale = [[en_GB]],name = [[korgall]]};
arRealms['eu']['Kragjin'] = {locale = [[de_DE]],name = [[kragjin]]};
arRealms['eu']['Krasus'] = {locale = [[fr_FR]],name = [[krasus]]};
arRealms['eu']['KulTiras'] = {locale = [[en_GB]],name = [[kul-tiras]]};
arRealms['eu']['KultderVerdammten'] = {locale = [[de_DE]],name = [[kult-der-verdammten]]};
arRealms['eu']['LaCroisadeécarlate'] = {locale = [[fr_FR]],name = [[la-croisade-ecarlate]]};
arRealms['eu']['LaughingSkull'] = {locale = [[en_GB]],name = [[laughing-skull]]};
arRealms['eu']['LesClairvoyants'] = {locale = [[fr_FR]],name = [[les-clairvoyants]]};
arRealms['eu']['LesSentinelles'] = {locale = [[fr_FR]],name = [[les-sentinelles]]};
arRealms['eu']['Lightbringer'] = {locale = [[en_GB]],name = [[lightbringer]]};
arRealms['eu']['LightningsBlade'] = {locale = [[en_GB]],name = [[lightnings-blade]]};
arRealms['eu']['Lordaeron'] = {locale = [[de_DE]],name = [[lordaeron]]};
arRealms['eu']['LosErrantes'] = {locale = [[es_ES]],name = [[los-errantes]]};
arRealms['eu']['Lothar'] = {locale = [[de_DE]],name = [[lothar]]};
arRealms['eu']['Madmortem'] = {locale = [[de_DE]],name = [[madmortem]]};
arRealms['eu']['Magtheridon'] = {locale = [[en_GB]],name = [[magtheridon]]};
arRealms['eu']['MalGanis'] = {locale = [[de_DE]],name = [[malganis]]};
arRealms['eu']['Malfurion'] = {locale = [[de_DE]],name = [[malfurion]]};
arRealms['eu']['Malorne'] = {locale = [[de_DE]],name = [[malorne]]};
arRealms['eu']['Malygos'] = {locale = [[de_DE]],name = [[malygos]]};
arRealms['eu']['Mannoroth'] = {locale = [[de_DE]],name = [[mannoroth]]};
arRealms['eu']['MarécagedeZangar'] = {locale = [[fr_FR]],name = [[marecage-de-zangar]]};
arRealms['eu']['Mazrigos'] = {locale = [[en_GB]],name = [[mazrigos]]};
arRealms['eu']['Medivh'] = {locale = [[fr_FR]],name = [[medivh]]};
arRealms['eu']['Minahonda'] = {locale = [[es_ES]],name = [[minahonda]]};
arRealms['eu']['Moonglade'] = {locale = [[en_GB]],name = [[moonglade]]};
arRealms['eu']['Mugthol'] = {locale = [[de_DE]],name = [[mugthol]]};
arRealms['eu']['Nagrand'] = {locale = [[en_GB]],name = [[nagrand]]};
arRealms['eu']['Nathrezim'] = {locale = [[de_DE]],name = [[nathrezim]]};
arRealms['eu']['Naxxramas'] = {locale = [[fr_FR]],name = [[naxxramas]]};
arRealms['eu']['Nazjatar'] = {locale = [[de_DE]],name = [[nazjatar]]};
arRealms['eu']['Nefarian'] = {locale = [[de_DE]],name = [[nefarian]]};
arRealms['eu']['Nemesis'] = {locale = [[it_IT]],name = [[nemesis]]};
arRealms['eu']['Neptulon'] = {locale = [[en_GB]],name = [[neptulon]]};
arRealms['eu']['Nerzhul'] = {locale = [[fr_FR]],name = [[nerzhul]]};
arRealms['eu']['Nerathor'] = {locale = [[de_DE]],name = [[nerathor]]};
arRealms['eu']['Nethersturm'] = {locale = [[de_DE]],name = [[nethersturm]]};
arRealms['eu']['Nordrassil'] = {locale = [[en_GB]],name = [[nordrassil]]};
arRealms['eu']['Norgannon'] = {locale = [[de_DE]],name = [[norgannon]]};
arRealms['eu']['Nozdormu'] = {locale = [[de_DE]],name = [[nozdormu]]};
arRealms['eu']['Onyxia'] = {locale = [[de_DE]],name = [[onyxia]]};
arRealms['eu']['Outland'] = {locale = [[en_GB]],name = [[outland]]};
arRealms['eu']['Perenolde'] = {locale = [[de_DE]],name = [[perenolde]]};
arRealms['eu']['PozzodellEternità'] = {locale = [[it_IT]],name = [[pozzo-delleternita]]};
arRealms['eu']['Proudmoore'] = {locale = [[de_DE]],name = [[proudmoore]]};
arRealms['eu']['QuelThalas'] = {locale = [[en_GB]],name = [[quelthalas]]};
arRealms['eu']['Ragnaros'] = {locale = [[en_GB]],name = [[ragnaros]]};
arRealms['eu']['Rajaxx'] = {locale = [[de_DE]],name = [[rajaxx]]};
arRealms['eu']['Rashgarroth'] = {locale = [[fr_FR]],name = [[rashgarroth]]};
arRealms['eu']['Ravencrest'] = {locale = [[en_GB]],name = [[ravencrest]]};
arRealms['eu']['Ravenholdt'] = {locale = [[en_GB]],name = [[ravenholdt]]};
arRealms['eu']['Rexxar'] = {locale = [[de_DE]],name = [[rexxar]]};
arRealms['eu']['Runetotem'] = {locale = [[en_GB]],name = [[runetotem]]};
arRealms['eu']['Sanguino'] = {locale = [[es_ES]],name = [[sanguino]]};
arRealms['eu']['Sargeras'] = {locale = [[fr_FR]],name = [[sargeras]]};
arRealms['eu']['Saurfang'] = {locale = [[en_GB]],name = [[saurfang]]};
arRealms['eu']['ScarshieldLegion'] = {locale = [[en_GB]],name = [[scarshield-legion]]};
arRealms['eu']['Senjin'] = {locale = [[de_DE]],name = [[senjin]]};
arRealms['eu']['Shadowsong'] = {locale = [[en_GB]],name = [[shadowsong]]};
arRealms['eu']['ShatteredHalls'] = {locale = [[en_GB]],name = [[shattered-halls]]};
arRealms['eu']['ShatteredHand'] = {locale = [[en_GB]],name = [[shattered-hand]]};
arRealms['eu']['Shattrath'] = {locale = [[de_DE]],name = [[shattrath]]};
arRealms['eu']['Shendralar'] = {locale = [[es_ES]],name = [[shendralar]]};
arRealms['eu']['Silvermoon'] = {locale = [[en_GB]],name = [[silvermoon]]};
arRealms['eu']['Sinstralis'] = {locale = [[fr_FR]],name = [[sinstralis]]};
arRealms['eu']['Skullcrusher'] = {locale = [[en_GB]],name = [[skullcrusher]]};
arRealms['eu']['Spinebreaker'] = {locale = [[en_GB]],name = [[spinebreaker]]};
arRealms['eu']['Spirestone'] = {locale = [[es_ES]],name = [[spirestone]]};
arRealms['eu']['Sporeggar'] = {locale = [[en_GB]],name = [[sporeggar]]};
arRealms['eu']['SteamwheedleCartel'] = {locale = [[en_GB]],name = [[steamwheedle-cartel]]};
arRealms['eu']['Stormrage'] = {locale = [[en_GB]],name = [[stormrage]]};
arRealms['eu']['Stormreaver'] = {locale = [[en_GB]],name = [[stormreaver]]};
arRealms['eu']['Stormscale'] = {locale = [[en_GB]],name = [[stormscale]]};
arRealms['eu']['Sunstrider'] = {locale = [[en_GB]],name = [[sunstrider]]};
arRealms['eu']['Sylvanas'] = {locale = [[en_GB]],name = [[sylvanas]]};
arRealms['eu']['Taerar'] = {locale = [[de_DE]],name = [[taerar]]};
arRealms['eu']['Talnivarr'] = {locale = [[en_GB]],name = [[talnivarr]]};
arRealms['eu']['TarrenMill'] = {locale = [[en_GB]],name = [[tarren-mill]]};
arRealms['eu']['Teldrassil'] = {locale = [[de_DE]],name = [[teldrassil]]};
arRealms['eu']['Templenoir'] = {locale = [[fr_FR]],name = [[temple-noir]]};
arRealms['eu']['Terenas'] = {locale = [[en_GB]],name = [[terenas]]};
arRealms['eu']['Terokkar'] = {locale = [[en_GB]],name = [[terokkar]]};
arRealms['eu']['Terrordar'] = {locale = [[de_DE]],name = [[terrordar]]};
arRealms['eu']['TheMaelstrom'] = {locale = [[en_GB]],name = [[the-maelstrom]]};
arRealms['eu']['TheShatar'] = {locale = [[en_GB]],name = [[the-shatar]]};
arRealms['eu']['TheVentureCo'] = {locale = [[en_GB]],name = [[the-venture-co]]};
arRealms['eu']['Theradras'] = {locale = [[de_DE]],name = [[theradras]]};
arRealms['eu']['Thrall'] = {locale = [[de_DE]],name = [[thrall]]};
arRealms['eu']['ThrokFeroth'] = {locale = [[fr_FR]],name = [[throkferoth]]};
arRealms['eu']['Thunderhorn'] = {locale = [[en_GB]],name = [[thunderhorn]]};
arRealms['eu']['Tichondrius'] = {locale = [[de_DE]],name = [[tichondrius]]};
arRealms['eu']['Tirion'] = {locale = [[de_DE]],name = [[tirion]]};
arRealms['eu']['Todeswache'] = {locale = [[de_DE]],name = [[todeswache]]};
arRealms['eu']['Trollbane'] = {locale = [[en_GB]],name = [[trollbane]]};
arRealms['eu']['Turalyon'] = {locale = [[en_GB]],name = [[turalyon]]};
arRealms['eu']['TwilightsHammer'] = {locale = [[en_GB]],name = [[twilights-hammer]]};
arRealms['eu']['TwistingNether'] = {locale = [[en_GB]],name = [[twisting-nether]]};
arRealms['eu']['Tyrande'] = {locale = [[es_ES]],name = [[tyrande]]};
arRealms['eu']['Uldaman'] = {locale = [[fr_FR]],name = [[uldaman]]};
arRealms['eu']['Ulduar'] = {locale = [[de_DE]],name = [[ulduar]]};
arRealms['eu']['Uldum'] = {locale = [[es_ES]],name = [[uldum]]};
arRealms['eu']['UnGoro'] = {locale = [[de_DE]],name = [[ungoro]]};
arRealms['eu']['Varimathras'] = {locale = [[fr_FR]],name = [[varimathras]]};
arRealms['eu']['Vashj'] = {locale = [[en_GB]],name = [[vashj]]};
arRealms['eu']['Veklor'] = {locale = [[de_DE]],name = [[veklor]]};
arRealms['eu']['Veknilash'] = {locale = [[en_GB]],name = [[veknilash]]};
arRealms['eu']['Voljin'] = {locale = [[fr_FR]],name = [[voljin]]};
arRealms['eu']['Wildhammer'] = {locale = [[en_GB]],name = [[wildhammer]]};
arRealms['eu']['Wrathbringer'] = {locale = [[de_DE]],name = [[wrathbringer]]};
arRealms['eu']['Xavius'] = {locale = [[en_GB]],name = [[xavius]]};
arRealms['eu']['Ysera'] = {locale = [[de_DE]],name = [[ysera]]};
arRealms['eu']['Ysondre'] = {locale = [[fr_FR]],name = [[ysondre]]};
arRealms['eu']['Zenedar'] = {locale = [[en_GB]],name = [[zenedar]]};
arRealms['eu']['ZirkeldesCenarius'] = {locale = [[de_DE]],name = [[zirkel-des-cenarius]]};
arRealms['eu']['Zuljin'] = {locale = [[es_ES]],name = [[zuljin]]};
arRealms['eu']['Zuluhed'] = {locale = [[de_DE]],name = [[zuluhed]]};
arRealms['eu']['Азурегос'] = {locale = [[ru_RU]],name = [[азурегос]]};
arRealms['eu']['Борейскаятундра'] = {locale = [[ru_RU]],name = [[бореиская-тундра]]};
arRealms['eu']['ВечнаяПесня'] = {locale = [[ru_RU]],name = [[вечная-песня]]};
arRealms['eu']['Галакронд'] = {locale = [[ru_RU]],name = [[галакронд]]};
arRealms['eu']['Голдринн'] = {locale = [[ru_RU]],name = [[голдринн]]};
arRealms['eu']['Гордунни'] = {locale = [[ru_RU]],name = [[гордунни]]};
arRealms['eu']['Гром'] = {locale = [[ru_RU]],name = [[гром]]};
arRealms['eu']['Дракономор'] = {locale = [[ru_RU]],name = [[дракономор]]};
arRealms['eu']['Корольлич'] = {locale = [[ru_RU]],name = [[корольлич]]};
arRealms['eu']['Пиратскаябухта'] = {locale = [[ru_RU]],name = [[пиратская-бухта]]};
arRealms['eu']['Подземье'] = {locale = [[ru_RU]],name = [[подземье]]};
arRealms['eu']['Разувий'] = {locale = [[ru_RU]],name = [[разувии]]};
arRealms['eu']['Ревущийфьорд'] = {locale = [[ru_RU]],name = [[ревущии-фьорд]]};
arRealms['eu']['СвежевательДуш'] = {locale = [[ru_RU]],name = [[свежеватель-душ]]};
arRealms['eu']['Седогрив'] = {locale = [[ru_RU]],name = [[седогрив]]};
arRealms['eu']['СтражСмерти'] = {locale = [[ru_RU]],name = [[страж-смерти]]};
arRealms['eu']['Термоштепсель'] = {locale = [[ru_RU]],name = [[термоштепсель]]};
arRealms['eu']['ТкачСмерти'] = {locale = [[ru_RU]],name = [[ткач-смерти]]};
arRealms['eu']['ЧерныйШрам'] = {locale = [[ru_RU]],name = [[черныи-шрам]]};
arRealms['eu']['Ясеневыйлес'] = {locale = [[ru_RU]],name = [[ясеневыи-лес]]};

arRealms['kr']['데스윙'] = {locale = [[ko_KR]],name = [[데스윙]]};
arRealms['kr']['듀로탄'] = {locale = [[ko_KR]],name = [[듀로탄]]};
arRealms['kr']['불타는군단'] = {locale = [[ko_KR]],name = [[불타는-군단]]};
arRealms['kr']['세나리우스'] = {locale = [[ko_KR]],name = [[세나리우스]]};
arRealms['kr']['아즈샤라'] = {locale = [[ko_KR]],name = [[아즈샤라]]};
arRealms['kr']['윈드러너'] = {locale = [[ko_KR]],name = [[윈드러너]]};
arRealms['kr']['줄진'] = {locale = [[ko_KR]],name = [[줄진]]};
arRealms['kr']['하이잘'] = {locale = [[ko_KR]],name = [[하이잘]]};
arRealms['kr']['헬스크림'] = {locale = [[ko_KR]],name = [[헬스크림]]};

arRealms['tw']['世界之樹'] = {locale = [[zh_TW]],name = [[世界之樹]]};
arRealms['tw']['亞雷戈斯'] = {locale = [[zh_TW]],name = [[亞雷戈斯]]};
arRealms['tw']['冰霜之刺'] = {locale = [[zh_TW]],name = [[冰霜之刺]]};
arRealms['tw']['冰風崗哨'] = {locale = [[zh_TW]],name = [[冰風崗哨]]};
arRealms['tw']['地獄吼'] = {locale = [[zh_TW]],name = [[地獄吼]]};
arRealms['tw']['夜空之歌'] = {locale = [[zh_TW]],name = [[夜空之歌]]};
arRealms['tw']['天空之牆'] = {locale = [[zh_TW]],name = [[天空之牆]]};
arRealms['tw']['寒冰皇冠'] = {locale = [[zh_TW]],name = [[寒冰皇冠]]};
arRealms['tw']['尖石'] = {locale = [[zh_TW]],name = [[尖石]]};
arRealms['tw']['屠魔山谷'] = {locale = [[zh_TW]],name = [[屠魔山谷]]};
arRealms['tw']['巨龍之喉'] = {locale = [[zh_TW]],name = [[巨龍之喉]]};
arRealms['tw']['憤怒使者'] = {locale = [[zh_TW]],name = [[憤怒使者]]};
arRealms['tw']['日落沼澤'] = {locale = [[zh_TW]],name = [[日落沼澤]]};
arRealms['tw']['暗影之月'] = {locale = [[zh_TW]],name = [[暗影之月]]};
arRealms['tw']['水晶之刺'] = {locale = [[zh_TW]],name = [[水晶之刺]]};
arRealms['tw']['狂熱之刃'] = {locale = [[zh_TW]],name = [[狂熱之刃]]};
arRealms['tw']['眾星之子'] = {locale = [[zh_TW]],name = [[眾星之子]]};
arRealms['tw']['米奈希爾'] = {locale = [[zh_TW]],name = [[米奈希爾]]};
arRealms['tw']['聖光之願'] = {locale = [[zh_TW]],name = [[聖光之願]]};
arRealms['tw']['血之谷'] = {locale = [[zh_TW]],name = [[血之谷]]};
arRealms['tw']['語風'] = {locale = [[zh_TW]],name = [[語風]]};
arRealms['tw']['銀翼要塞'] = {locale = [[zh_TW]],name = [[銀翼要塞]]};
arRealms['tw']['阿薩斯'] = {locale = [[zh_TW]],name = [[阿薩斯]]};
arRealms['tw']['雲蛟衛'] = {locale = [[zh_TW]],name = [[雲蛟衛]]};
arRealms['tw']['雷鱗'] = {locale = [[zh_TW]],name = [[雷鱗]]};

arRealms['cn']['万色星辰'] = {locale = [[zh_CN]],name = [[万色星辰]]};
arRealms['cn']['世界之树'] = {locale = [[zh_CN]],name = [[世界之树]]};
arRealms['cn']['丹莫德'] = {locale = [[zh_CN]],name = [[丹莫德]]};
arRealms['cn']['主宰之剑'] = {locale = [[zh_CN]],name = [[主宰之剑]]};
arRealms['cn']['丽丽四川'] = {locale = [[zh_CN]],name = [[丽丽四川]]};
arRealms['cn']['亚雷戈斯'] = {locale = [[zh_CN]],name = [[亚雷戈斯]]};
arRealms['cn']['亡语者'] = {locale = [[zh_CN]],name = [[亡语者]]};
arRealms['cn']['伊兰尼库斯'] = {locale = [[zh_CN]],name = [[伊兰尼库斯]]};
arRealms['cn']['伊利丹'] = {locale = [[zh_CN]],name = [[伊利丹]]};
arRealms['cn']['伊森利恩'] = {locale = [[zh_CN]],name = [[伊森利恩]]};
arRealms['cn']['伊森德雷'] = {locale = [[zh_CN]],name = [[伊森德雷]]};
arRealms['cn']['伊瑟拉'] = {locale = [[zh_CN]],name = [[伊瑟拉]]};
arRealms['cn']['伊莫塔尔'] = {locale = [[zh_CN]],name = [[伊莫塔尔]]};
arRealms['cn']['伊萨里奥斯'] = {locale = [[zh_CN]],name = [[伊萨里奥斯]]};
arRealms['cn']['元素之力'] = {locale = [[zh_CN]],name = [[元素之力]]};
arRealms['cn']['克尔苏加德'] = {locale = [[zh_CN]],name = [[克尔苏加德]]};
arRealms['cn']['克洛玛古斯'] = {locale = [[zh_CN]],name = [[克洛玛古斯]]};
arRealms['cn']['克苏恩'] = {locale = [[zh_CN]],name = [[克苏恩]]};
arRealms['cn']['军团要塞'] = {locale = [[zh_CN]],name = [[军团要塞]]};
arRealms['cn']['冬拥湖'] = {locale = [[zh_CN]],name = [[冬拥湖]]};
arRealms['cn']['冬泉谷'] = {locale = [[zh_CN]],name = [[冬泉谷]]};
arRealms['cn']['冰川之拳'] = {locale = [[zh_CN]],name = [[冰川之拳]]};
arRealms['cn']['冰霜之刃'] = {locale = [[zh_CN]],name = [[冰霜之刃]]};
arRealms['cn']['冰风岗'] = {locale = [[zh_CN]],name = [[冰风岗]]};
arRealms['cn']['凤凰之神'] = {locale = [[zh_CN]],name = [[凤凰之神]]};
arRealms['cn']['凯尔萨斯'] = {locale = [[zh_CN]],name = [[凯尔萨斯]]};
arRealms['cn']['凯恩血蹄'] = {locale = [[zh_CN]],name = [[凯恩血蹄]]};
arRealms['cn']['利刃之拳'] = {locale = [[zh_CN]],name = [[利刃之拳]]};
arRealms['cn']['刺骨利刃'] = {locale = [[zh_CN]],name = [[刺骨利刃]]};
arRealms['cn']['加兹鲁维'] = {locale = [[zh_CN]],name = [[加兹鲁维]]};
arRealms['cn']['加基森'] = {locale = [[zh_CN]],name = [[加基森]]};
arRealms['cn']['加尔'] = {locale = [[zh_CN]],name = [[加尔]]};
arRealms['cn']['加里索斯'] = {locale = [[zh_CN]],name = [[加里索斯]]};
arRealms['cn']['勇士岛'] = {locale = [[zh_CN]],name = [[勇士岛]]};
arRealms['cn']['千针石林'] = {locale = [[zh_CN]],name = [[千针石林]]};
arRealms['cn']['卡德加'] = {locale = [[zh_CN]],name = [[卡德加]]};
arRealms['cn']['卡德罗斯'] = {locale = [[zh_CN]],name = [[卡德罗斯]]};
arRealms['cn']['卡扎克'] = {locale = [[zh_CN]],name = [[卡扎克]]};
arRealms['cn']['卡拉赞'] = {locale = [[zh_CN]],name = [[卡拉赞]]};
arRealms['cn']['卡珊德拉'] = {locale = [[zh_CN]],name = [[卡珊德拉]]};
arRealms['cn']['厄祖玛特'] = {locale = [[zh_CN]],name = [[厄祖玛特]]};
arRealms['cn']['古加尔'] = {locale = [[zh_CN]],name = [[古加尔]]};
arRealms['cn']['古尔丹'] = {locale = [[zh_CN]],name = [[古尔丹]]};
arRealms['cn']['古拉巴什'] = {locale = [[zh_CN]],name = [[古拉巴什]]};
arRealms['cn']['古达克'] = {locale = [[zh_CN]],name = [[古达克]]};
arRealms['cn']['哈兰'] = {locale = [[zh_CN]],name = [[哈兰]]};
arRealms['cn']['哈卡'] = {locale = [[zh_CN]],name = [[哈卡]]};
arRealms['cn']['嚎风峡湾'] = {locale = [[zh_CN]],name = [[嚎风峡湾]]};
arRealms['cn']['回音山'] = {locale = [[zh_CN]],name = [[回音山]]};
arRealms['cn']['国王之谷'] = {locale = [[zh_CN]],name = [[国王之谷]]};
arRealms['cn']['图拉扬'] = {locale = [[zh_CN]],name = [[图拉扬]]};
arRealms['cn']['圣火神殿'] = {locale = [[zh_CN]],name = [[圣火神殿]]};
arRealms['cn']['地狱之石'] = {locale = [[zh_CN]],name = [[地狱之石]]};
arRealms['cn']['地狱咆哮'] = {locale = [[zh_CN]],name = [[地狱咆哮]]};
arRealms['cn']['埃克索图斯'] = {locale = [[zh_CN]],name = [[埃克索图斯]]};
arRealms['cn']['埃加洛尔'] = {locale = [[zh_CN]],name = [[埃加洛尔]]};
arRealms['cn']['埃基尔松'] = {locale = [[zh_CN]],name = [[埃基尔松]]};
arRealms['cn']['埃德萨拉'] = {locale = [[zh_CN]],name = [[埃德萨拉]]};
arRealms['cn']['埃苏雷格'] = {locale = [[zh_CN]],name = [[埃苏雷格]]};
arRealms['cn']['埃雷达尔'] = {locale = [[zh_CN]],name = [[埃雷达尔]]};
arRealms['cn']['基尔加丹'] = {locale = [[zh_CN]],name = [[基尔加丹]]};
arRealms['cn']['基尔罗格'] = {locale = [[zh_CN]],name = [[基尔罗格]]};
arRealms['cn']['塔纳利斯'] = {locale = [[zh_CN]],name = [[塔纳利斯]]};
arRealms['cn']['塞拉摩'] = {locale = [[zh_CN]],name = [[塞拉摩]]};
arRealms['cn']['塞拉赞恩'] = {locale = [[zh_CN]],name = [[塞拉赞恩]]};
arRealms['cn']['塞泰克'] = {locale = [[zh_CN]],name = [[塞泰克]]};
arRealms['cn']['塞纳里奥'] = {locale = [[zh_CN]],name = [[塞纳里奥]]};
arRealms['cn']['壁炉谷'] = {locale = [[zh_CN]],name = [[壁炉谷]]};
arRealms['cn']['夏维安'] = {locale = [[zh_CN]],name = [[夏维安]]};
arRealms['cn']['外域'] = {locale = [[zh_CN]],name = [[外域]]};
arRealms['cn']['大地之怒'] = {locale = [[zh_CN]],name = [[大地之怒]]};
arRealms['cn']['大漩涡'] = {locale = [[zh_CN]],name = [[大漩涡]]};
arRealms['cn']['天空之墙'] = {locale = [[zh_CN]],name = [[天空之墙]]};
arRealms['cn']['天谴之门'] = {locale = [[zh_CN]],name = [[天谴之门]]};
arRealms['cn']['太阳之井'] = {locale = [[zh_CN]],name = [[太阳之井]]};
arRealms['cn']['夺灵者'] = {locale = [[zh_CN]],name = [[夺灵者]]};
arRealms['cn']['奈法利安'] = {locale = [[zh_CN]],name = [[奈法利安]]};
arRealms['cn']['奈萨里奥'] = {locale = [[zh_CN]],name = [[奈萨里奥]]};
arRealms['cn']['奎尔丹纳斯'] = {locale = [[zh_CN]],name = [[奎尔丹纳斯]]};
arRealms['cn']['奎尔萨拉斯'] = {locale = [[zh_CN]],name = [[奎尔萨拉斯]]};
arRealms['cn']['奥妮克希亚'] = {locale = [[zh_CN]],name = [[奥妮克希亚]]};
arRealms['cn']['奥尔加隆'] = {locale = [[zh_CN]],name = [[奥尔加隆]]};
arRealms['cn']['奥拉基尔'] = {locale = [[zh_CN]],name = [[奥拉基尔]]};
arRealms['cn']['奥斯里安'] = {locale = [[zh_CN]],name = [[奥斯里安]]};
arRealms['cn']['奥杜尔'] = {locale = [[zh_CN]],name = [[奥杜尔]]};
arRealms['cn']['奥特兰克'] = {locale = [[zh_CN]],name = [[奥特兰克]]};
arRealms['cn']['奥蕾莉亚'] = {locale = [[zh_CN]],name = [[奥蕾莉亚]]};
arRealms['cn']['奥达曼'] = {locale = [[zh_CN]],name = [[奥达曼]]};
arRealms['cn']['守护之剑'] = {locale = [[zh_CN]],name = [[守护之剑]]};
arRealms['cn']['安东尼达斯'] = {locale = [[zh_CN]],name = [[安东尼达斯]]};
arRealms['cn']['安其拉'] = {locale = [[zh_CN]],name = [[安其拉]]};
arRealms['cn']['安加萨'] = {locale = [[zh_CN]],name = [[安加萨]]};
arRealms['cn']['安威玛尔'] = {locale = [[zh_CN]],name = [[安威玛尔]]};
arRealms['cn']['安戈洛'] = {locale = [[zh_CN]],name = [[安戈洛]]};
arRealms['cn']['安格博达'] = {locale = [[zh_CN]],name = [[安格博达]]};
arRealms['cn']['安纳塞隆'] = {locale = [[zh_CN]],name = [[安纳塞隆]]};
arRealms['cn']['安苏'] = {locale = [[zh_CN]],name = [[安苏]]};
arRealms['cn']['密林游侠'] = {locale = [[zh_CN]],name = [[密林游侠]]};
arRealms['cn']['寒冰皇冠'] = {locale = [[zh_CN]],name = [[寒冰皇冠]]};
arRealms['cn']['尘风峡谷'] = {locale = [[zh_CN]],name = [[尘风峡谷]]};
arRealms['cn']['屠魔山谷'] = {locale = [[zh_CN]],name = [[屠魔山谷]]};
arRealms['cn']['山丘之王'] = {locale = [[zh_CN]],name = [[山丘之王]]};
arRealms['cn']['巨龙之吼'] = {locale = [[zh_CN]],name = [[巨龙之吼]]};
arRealms['cn']['巫妖之王'] = {locale = [[zh_CN]],name = [[巫妖之王]]};
arRealms['cn']['巴尔古恩'] = {locale = [[zh_CN]],name = [[巴尔古恩]]};
arRealms['cn']['巴瑟拉斯'] = {locale = [[zh_CN]],name = [[巴瑟拉斯]]};
arRealms['cn']['巴纳扎尔'] = {locale = [[zh_CN]],name = [[巴纳扎尔]]};
arRealms['cn']['布兰卡德'] = {locale = [[zh_CN]],name = [[布兰卡德]]};
arRealms['cn']['布莱克摩'] = {locale = [[zh_CN]],name = [[布莱克摩]]};
arRealms['cn']['布莱恩'] = {locale = [[zh_CN]],name = [[布莱恩]]};
arRealms['cn']['布鲁塔卢斯'] = {locale = [[zh_CN]],name = [[布鲁塔卢斯]]};
arRealms['cn']['希尔瓦娜斯'] = {locale = [[zh_CN]],name = [[希尔瓦娜斯]]};
arRealms['cn']['希雷诺斯'] = {locale = [[zh_CN]],name = [[希雷诺斯]]};
arRealms['cn']['幽暗沼泽'] = {locale = [[zh_CN]],name = [[幽暗沼泽]]};
arRealms['cn']['库尔提拉斯'] = {locale = [[zh_CN]],name = [[库尔提拉斯]]};
arRealms['cn']['库德兰'] = {locale = [[zh_CN]],name = [[库德兰]]};
arRealms['cn']['弗塞雷迦'] = {locale = [[zh_CN]],name = [[弗塞雷迦]]};
arRealms['cn']['影之哀伤'] = {locale = [[zh_CN]],name = [[影之哀伤]]};
arRealms['cn']['影牙要塞'] = {locale = [[zh_CN]],name = [[影牙要塞]]};
arRealms['cn']['德拉诺'] = {locale = [[zh_CN]],name = [[德拉诺]]};
arRealms['cn']['恐怖图腾'] = {locale = [[zh_CN]],name = [[恐怖图腾]]};
arRealms['cn']['恶魔之翼'] = {locale = [[zh_CN]],name = [[恶魔之翼]]};
arRealms['cn']['恶魔之魂'] = {locale = [[zh_CN]],name = [[恶魔之魂]]};
arRealms['cn']['戈古纳斯'] = {locale = [[zh_CN]],name = [[戈古纳斯]]};
arRealms['cn']['戈提克'] = {locale = [[zh_CN]],name = [[戈提克]]};
arRealms['cn']['战歌'] = {locale = [[zh_CN]],name = [[战歌]]};
arRealms['cn']['扎拉赞恩'] = {locale = [[zh_CN]],name = [[扎拉赞恩]]};
arRealms['cn']['托塞德林'] = {locale = [[zh_CN]],name = [[托塞德林]]};
arRealms['cn']['托尔巴拉德'] = {locale = [[zh_CN]],name = [[托尔巴拉德]]};
arRealms['cn']['拉文凯斯'] = {locale = [[zh_CN]],name = [[拉文凯斯]]};
arRealms['cn']['拉文霍德'] = {locale = [[zh_CN]],name = [[拉文霍德]]};
arRealms['cn']['拉格纳洛斯'] = {locale = [[zh_CN]],name = [[拉格纳洛斯]]};
arRealms['cn']['拉贾克斯'] = {locale = [[zh_CN]],name = [[拉贾克斯]]};
arRealms['cn']['提尔之手'] = {locale = [[zh_CN]],name = [[提尔之手]]};
arRealms['cn']['提瑞斯法'] = {locale = [[zh_CN]],name = [[提瑞斯法]]};
arRealms['cn']['摩摩尔'] = {locale = [[zh_CN]],name = [[摩摩尔]]};
arRealms['cn']['斩魔者'] = {locale = [[zh_CN]],name = [[斩魔者]]};
arRealms['cn']['斯坦索姆'] = {locale = [[zh_CN]],name = [[斯坦索姆]]};
arRealms['cn']['无尽之海'] = {locale = [[zh_CN]],name = [[无尽之海]]};
arRealms['cn']['无底海渊'] = {locale = [[zh_CN]],name = [[无底海渊]]};
arRealms['cn']['日落沼泽'] = {locale = [[zh_CN]],name = [[日落沼泽]]};
arRealms['cn']['时光之穴'] = {locale = [[zh_CN]],name = [[时光之穴]]};
arRealms['cn']['普瑞斯托'] = {locale = [[zh_CN]],name = [[普瑞斯托]]};
arRealms['cn']['普罗德摩'] = {locale = [[zh_CN]],name = [[普罗德摩]]};
arRealms['cn']['晴日峰江苏'] = {locale = [[zh_CN]],name = [[晴日峰江苏]]};
arRealms['cn']['暗影之月'] = {locale = [[zh_CN]],name = [[暗影之月]]};
arRealms['cn']['暗影裂口'] = {locale = [[zh_CN]],name = [[暗影裂口]]};
arRealms['cn']['暗影议会'] = {locale = [[zh_CN]],name = [[暗影议会]]};
arRealms['cn']['暗影迷宫'] = {locale = [[zh_CN]],name = [[暗影迷宫]]};
arRealms['cn']['暮色森林'] = {locale = [[zh_CN]],name = [[暮色森林]]};
arRealms['cn']['暴风祭坛'] = {locale = [[zh_CN]],name = [[暴风祭坛]]};
arRealms['cn']['月光林地'] = {locale = [[zh_CN]],name = [[月光林地]]};
arRealms['cn']['月神殿'] = {locale = [[zh_CN]],name = [[月神殿]]};
arRealms['cn']['末日祷告祭坛'] = {locale = [[zh_CN]],name = [[末日祷告祭坛]]};
arRealms['cn']['末日行者'] = {locale = [[zh_CN]],name = [[末日行者]]};
arRealms['cn']['朵丹尼尔'] = {locale = [[zh_CN]],name = [[朵丹尼尔]]};
arRealms['cn']['杜隆坦'] = {locale = [[zh_CN]],name = [[杜隆坦]]};
arRealms['cn']['格瑞姆巴托'] = {locale = [[zh_CN]],name = [[格瑞姆巴托]]};
arRealms['cn']['格雷迈恩'] = {locale = [[zh_CN]],name = [[格雷迈恩]]};
arRealms['cn']['格鲁尔'] = {locale = [[zh_CN]],name = [[格鲁尔]]};
arRealms['cn']['桑德兰'] = {locale = [[zh_CN]],name = [[桑德兰]]};
arRealms['cn']['梅尔加尼'] = {locale = [[zh_CN]],name = [[梅尔加尼]]};
arRealms['cn']['梦境之树'] = {locale = [[zh_CN]],name = [[梦境之树]]};
arRealms['cn']['森金'] = {locale = [[zh_CN]],name = [[森金]]};
arRealms['cn']['死亡之翼'] = {locale = [[zh_CN]],name = [[死亡之翼]]};
arRealms['cn']['死亡熔炉'] = {locale = [[zh_CN]],name = [[死亡熔炉]]};
arRealms['cn']['毁灭之锤'] = {locale = [[zh_CN]],name = [[毁灭之锤]]};
arRealms['cn']['永夜港'] = {locale = [[zh_CN]],name = [[永夜港]]};
arRealms['cn']['永恒之井'] = {locale = [[zh_CN]],name = [[永恒之井]]};
arRealms['cn']['沃金'] = {locale = [[zh_CN]],name = [[沃金]]};
arRealms['cn']['沙怒'] = {locale = [[zh_CN]],name = [[沙怒]]};
arRealms['cn']['法拉希姆'] = {locale = [[zh_CN]],name = [[法拉希姆]]};
arRealms['cn']['泰兰德'] = {locale = [[zh_CN]],name = [[泰兰德]]};
arRealms['cn']['泰拉尔'] = {locale = [[zh_CN]],name = [[泰拉尔]]};
arRealms['cn']['洛丹伦'] = {locale = [[zh_CN]],name = [[洛丹伦]]};
arRealms['cn']['洛肯'] = {locale = [[zh_CN]],name = [[洛肯]]};
arRealms['cn']['洛萨'] = {locale = [[zh_CN]],name = [[洛萨]]};
arRealms['cn']['海克泰尔'] = {locale = [[zh_CN]],name = [[海克泰尔]]};
arRealms['cn']['海加尔'] = {locale = [[zh_CN]],name = [[海加尔]]};
arRealms['cn']['海达希亚'] = {locale = [[zh_CN]],name = [[海达希亚]]};
arRealms['cn']['深渊之喉'] = {locale = [[zh_CN]],name = [[深渊之喉]]};
arRealms['cn']['深渊之巢'] = {locale = [[zh_CN]],name = [[深渊之巢]]};
arRealms['cn']['激流之傲'] = {locale = [[zh_CN]],name = [[激流之傲]]};
arRealms['cn']['激流堡'] = {locale = [[zh_CN]],name = [[激流堡]]};
arRealms['cn']['火喉'] = {locale = [[zh_CN]],name = [[火喉]]};
arRealms['cn']['火烟之谷'] = {locale = [[zh_CN]],name = [[火烟之谷]]};
arRealms['cn']['火焰之树'] = {locale = [[zh_CN]],name = [[火焰之树]]};
arRealms['cn']['火羽山'] = {locale = [[zh_CN]],name = [[火羽山]]};
arRealms['cn']['灰谷'] = {locale = [[zh_CN]],name = [[灰谷]]};
arRealms['cn']['烈焰峰'] = {locale = [[zh_CN]],name = [[烈焰峰]]};
arRealms['cn']['烈焰荆棘'] = {locale = [[zh_CN]],name = [[烈焰荆棘]]};
arRealms['cn']['熊猫酒仙'] = {locale = [[zh_CN]],name = [[熊猫酒仙]]};
arRealms['cn']['熔火之心'] = {locale = [[zh_CN]],name = [[熔火之心]]};
arRealms['cn']['熵魔'] = {locale = [[zh_CN]],name = [[熵魔]]};
arRealms['cn']['燃烧之刃'] = {locale = [[zh_CN]],name = [[燃烧之刃]]};
arRealms['cn']['燃烧军团'] = {locale = [[zh_CN]],name = [[燃烧军团]]};
arRealms['cn']['燃烧平原'] = {locale = [[zh_CN]],name = [[燃烧平原]]};
arRealms['cn']['爱斯特纳'] = {locale = [[zh_CN]],name = [[爱斯特纳]]};
arRealms['cn']['狂热之刃'] = {locale = [[zh_CN]],name = [[狂热之刃]]};
arRealms['cn']['狂风峭壁'] = {locale = [[zh_CN]],name = [[狂风峭壁]]};
arRealms['cn']['玛多兰'] = {locale = [[zh_CN]],name = [[玛多兰]]};
arRealms['cn']['玛法里奥'] = {locale = [[zh_CN]],name = [[玛法里奥]]};
arRealms['cn']['玛洛加尔'] = {locale = [[zh_CN]],name = [[玛洛加尔]]};
arRealms['cn']['玛瑟里顿'] = {locale = [[zh_CN]],name = [[玛瑟里顿]]};
arRealms['cn']['玛诺洛斯'] = {locale = [[zh_CN]],name = [[玛诺洛斯]]};
arRealms['cn']['玛里苟斯'] = {locale = [[zh_CN]],name = [[玛里苟斯]]};
arRealms['cn']['瑞文戴尔'] = {locale = [[zh_CN]],name = [[瑞文戴尔]]};
arRealms['cn']['瑟莱德丝'] = {locale = [[zh_CN]],name = [[瑟莱德丝]]};
arRealms['cn']['瓦丝琪'] = {locale = [[zh_CN]],name = [[瓦丝琪]]};
arRealms['cn']['瓦拉斯塔兹'] = {locale = [[zh_CN]],name = [[瓦拉斯塔兹]]};
arRealms['cn']['瓦拉纳'] = {locale = [[zh_CN]],name = [[瓦拉纳]]};
arRealms['cn']['瓦里玛萨斯'] = {locale = [[zh_CN]],name = [[瓦里玛萨斯]]};
arRealms['cn']['甜水绿洲'] = {locale = [[zh_CN]],name = [[甜水绿洲]]};
arRealms['cn']['生态船'] = {locale = [[zh_CN]],name = [[生态船]]};
arRealms['cn']['白银之手'] = {locale = [[zh_CN]],name = [[白银之手]]};
arRealms['cn']['白骨荒野'] = {locale = [[zh_CN]],name = [[白骨荒野]]};
arRealms['cn']['盖斯'] = {locale = [[zh_CN]],name = [[盖斯]]};
arRealms['cn']['石爪峰'] = {locale = [[zh_CN]],name = [[石爪峰]]};
arRealms['cn']['石锤'] = {locale = [[zh_CN]],name = [[石锤]]};
arRealms['cn']['破碎岭'] = {locale = [[zh_CN]],name = [[破碎岭]]};
arRealms['cn']['祖尔金'] = {locale = [[zh_CN]],name = [[祖尔金]]};
arRealms['cn']['祖达克'] = {locale = [[zh_CN]],name = [[祖达克]]};
arRealms['cn']['祖阿曼'] = {locale = [[zh_CN]],name = [[祖阿曼]]};
arRealms['cn']['神圣之歌'] = {locale = [[zh_CN]],name = [[神圣之歌]]};
arRealms['cn']['穆戈尔'] = {locale = [[zh_CN]],name = [[穆戈尔]]};
arRealms['cn']['符文图腾'] = {locale = [[zh_CN]],name = [[符文图腾]]};
arRealms['cn']['米奈希尔'] = {locale = [[zh_CN]],name = [[米奈希尔]]};
arRealms['cn']['索拉丁'] = {locale = [[zh_CN]],name = [[索拉丁]]};
arRealms['cn']['索瑞森'] = {locale = [[zh_CN]],name = [[索瑞森]]};
arRealms['cn']['红云台地'] = {locale = [[zh_CN]],name = [[红云台地]]};
arRealms['cn']['红龙军团'] = {locale = [[zh_CN]],name = [[红龙军团]]};
arRealms['cn']['红龙女王'] = {locale = [[zh_CN]],name = [[红龙女王]]};
arRealms['cn']['纳克萨玛斯'] = {locale = [[zh_CN]],name = [[纳克萨玛斯]]};
arRealms['cn']['纳沙塔尔'] = {locale = [[zh_CN]],name = [[纳沙塔尔]]};
arRealms['cn']['织亡者'] = {locale = [[zh_CN]],name = [[织亡者]]};
arRealms['cn']['罗宁'] = {locale = [[zh_CN]],name = [[罗宁]]};
arRealms['cn']['羽月'] = {locale = [[zh_CN]],name = [[羽月]]};
arRealms['cn']['翡翠梦境'] = {locale = [[zh_CN]],name = [[翡翠梦境]]};
arRealms['cn']['耐奥祖'] = {locale = [[zh_CN]],name = [[耐奥祖]]};
arRealms['cn']['耐普图隆'] = {locale = [[zh_CN]],name = [[耐普图隆]]};
arRealms['cn']['耳语海岸'] = {locale = [[zh_CN]],name = [[耳语海岸]]};
arRealms['cn']['能源舰'] = {locale = [[zh_CN]],name = [[能源舰]]};
arRealms['cn']['自由之风'] = {locale = [[zh_CN]],name = [[自由之风]]};
arRealms['cn']['艾森娜'] = {locale = [[zh_CN]],name = [[艾森娜]]};
arRealms['cn']['艾欧纳尔'] = {locale = [[zh_CN]],name = [[艾欧纳尔]]};
arRealms['cn']['艾维娜'] = {locale = [[zh_CN]],name = [[艾维娜]]};
arRealms['cn']['艾苏恩'] = {locale = [[zh_CN]],name = [[艾苏恩]]};
arRealms['cn']['艾莫莉丝'] = {locale = [[zh_CN]],name = [[艾莫莉丝]]};
arRealms['cn']['艾萨拉'] = {locale = [[zh_CN]],name = [[艾萨拉]]};
arRealms['cn']['艾露恩'] = {locale = [[zh_CN]],name = [[艾露恩]]};
arRealms['cn']['芬里斯'] = {locale = [[zh_CN]],name = [[芬里斯]]};
arRealms['cn']['苏塔恩'] = {locale = [[zh_CN]],name = [[苏塔恩]]};
arRealms['cn']['范克里夫'] = {locale = [[zh_CN]],name = [[范克里夫]]};
arRealms['cn']['范达尔鹿盔'] = {locale = [[zh_CN]],name = [[范达尔鹿盔]]};
arRealms['cn']['荆棘谷'] = {locale = [[zh_CN]],name = [[荆棘谷]]};
arRealms['cn']['莱索恩'] = {locale = [[zh_CN]],name = [[莱索恩]]};
arRealms['cn']['菲拉斯'] = {locale = [[zh_CN]],name = [[菲拉斯]]};
arRealms['cn']['菲米丝'] = {locale = [[zh_CN]],name = [[菲米丝]]};
arRealms['cn']['萨尔'] = {locale = [[zh_CN]],name = [[萨尔]]};
arRealms['cn']['萨格拉斯'] = {locale = [[zh_CN]],name = [[萨格拉斯]]};
arRealms['cn']['萨洛拉丝'] = {locale = [[zh_CN]],name = [[萨洛拉丝]]};
arRealms['cn']['萨菲隆'] = {locale = [[zh_CN]],name = [[萨菲隆]]};
arRealms['cn']['蓝龙军团'] = {locale = [[zh_CN]],name = [[蓝龙军团]]};
arRealms['cn']['藏宝海湾'] = {locale = [[zh_CN]],name = [[藏宝海湾]]};
arRealms['cn']['蜘蛛王国'] = {locale = [[zh_CN]],name = [[蜘蛛王国]]};
arRealms['cn']['血吼'] = {locale = [[zh_CN]],name = [[血吼]]};
arRealms['cn']['血牙魔王'] = {locale = [[zh_CN]],name = [[血牙魔王]]};
arRealms['cn']['血环'] = {locale = [[zh_CN]],name = [[血环]]};
arRealms['cn']['血羽'] = {locale = [[zh_CN]],name = [[血羽]]};
arRealms['cn']['血色十字军'] = {locale = [[zh_CN]],name = [[血色十字军]]};
arRealms['cn']['血顶'] = {locale = [[zh_CN]],name = [[血顶]]};
arRealms['cn']['试炼之环'] = {locale = [[zh_CN]],name = [[试炼之环]]};
arRealms['cn']['诺兹多姆'] = {locale = [[zh_CN]],name = [[诺兹多姆]]};
arRealms['cn']['诺森德'] = {locale = [[zh_CN]],name = [[诺森德]]};
arRealms['cn']['诺莫瑞根'] = {locale = [[zh_CN]],name = [[诺莫瑞根]]};
arRealms['cn']['贫瘠之地'] = {locale = [[zh_CN]],name = [[贫瘠之地]]};
arRealms['cn']['踏梦者'] = {locale = [[zh_CN]],name = [[踏梦者]]};
arRealms['cn']['轻风之语'] = {locale = [[zh_CN]],name = [[轻风之语]]};
arRealms['cn']['辛达苟萨'] = {locale = [[zh_CN]],name = [[辛达苟萨]]};
arRealms['cn']['达克萨隆'] = {locale = [[zh_CN]],name = [[达克萨隆]]};
arRealms['cn']['达基萨斯'] = {locale = [[zh_CN]],name = [[达基萨斯]]};
arRealms['cn']['达尔坎'] = {locale = [[zh_CN]],name = [[达尔坎]]};
arRealms['cn']['达文格尔'] = {locale = [[zh_CN]],name = [[达文格尔]]};
arRealms['cn']['达斯雷玛'] = {locale = [[zh_CN]],name = [[达斯雷玛]]};
arRealms['cn']['达纳斯'] = {locale = [[zh_CN]],name = [[达纳斯]]};
arRealms['cn']['达隆米尔'] = {locale = [[zh_CN]],name = [[达隆米尔]]};
arRealms['cn']['迅捷微风'] = {locale = [[zh_CN]],name = [[迅捷微风]]};
arRealms['cn']['远古海滩'] = {locale = [[zh_CN]],name = [[远古海滩]]};
arRealms['cn']['迦拉克隆'] = {locale = [[zh_CN]],name = [[迦拉克隆]]};
arRealms['cn']['迦玛兰'] = {locale = [[zh_CN]],name = [[迦玛兰]]};
arRealms['cn']['迦罗娜'] = {locale = [[zh_CN]],name = [[迦罗娜]]};
arRealms['cn']['迦顿'] = {locale = [[zh_CN]],name = [[迦顿]]};
arRealms['cn']['迪托马斯'] = {locale = [[zh_CN]],name = [[迪托马斯]]};
arRealms['cn']['迪瑟洛克'] = {locale = [[zh_CN]],name = [[迪瑟洛克]]};
arRealms['cn']['逐日者'] = {locale = [[zh_CN]],name = [[逐日者]]};
arRealms['cn']['通灵学院'] = {locale = [[zh_CN]],name = [[通灵学院]]};
arRealms['cn']['遗忘海岸'] = {locale = [[zh_CN]],name = [[遗忘海岸]]};
arRealms['cn']['金度'] = {locale = [[zh_CN]],name = [[金度]]};
arRealms['cn']['金色平原'] = {locale = [[zh_CN]],name = [[金色平原]]};
arRealms['cn']['铜龙军团'] = {locale = [[zh_CN]],name = [[铜龙军团]]};
arRealms['cn']['银月'] = {locale = [[zh_CN]],name = [[银月]]};
arRealms['cn']['银松森林'] = {locale = [[zh_CN]],name = [[银松森林]]};
arRealms['cn']['闪电之刃'] = {locale = [[zh_CN]],name = [[闪电之刃]]};
arRealms['cn']['阿克蒙德'] = {locale = [[zh_CN]],name = [[阿克蒙德]]};
arRealms['cn']['阿努巴拉克'] = {locale = [[zh_CN]],name = [[阿努巴拉克]]};
arRealms['cn']['阿卡玛'] = {locale = [[zh_CN]],name = [[阿卡玛]]};
arRealms['cn']['阿古斯'] = {locale = [[zh_CN]],name = [[阿古斯]]};
arRealms['cn']['阿尔萨斯'] = {locale = [[zh_CN]],name = [[阿尔萨斯]]};
arRealms['cn']['阿扎达斯'] = {locale = [[zh_CN]],name = [[阿扎达斯]]};
arRealms['cn']['阿拉希'] = {locale = [[zh_CN]],name = [[阿拉希]]};
arRealms['cn']['阿拉索'] = {locale = [[zh_CN]],name = [[阿拉索]]};
arRealms['cn']['阿斯塔洛'] = {locale = [[zh_CN]],name = [[阿斯塔洛]]};
arRealms['cn']['阿曼尼'] = {locale = [[zh_CN]],name = [[阿曼尼]]};
arRealms['cn']['阿格拉玛'] = {locale = [[zh_CN]],name = [[阿格拉玛]]};
arRealms['cn']['阿比迪斯'] = {locale = [[zh_CN]],name = [[阿比迪斯]]};
arRealms['cn']['阿纳克洛斯'] = {locale = [[zh_CN]],name = [[阿纳克洛斯]]};
arRealms['cn']['阿迦玛甘'] = {locale = [[zh_CN]],name = [[阿迦玛甘]]};
arRealms['cn']['雏龙之翼'] = {locale = [[zh_CN]],name = [[雏龙之翼]]};
arRealms['cn']['雷克萨'] = {locale = [[zh_CN]],name = [[雷克萨]]};
arRealms['cn']['雷斧堡垒'] = {locale = [[zh_CN]],name = [[雷斧堡垒]]};
arRealms['cn']['雷霆之怒'] = {locale = [[zh_CN]],name = [[雷霆之怒]]};
arRealms['cn']['雷霆之王'] = {locale = [[zh_CN]],name = [[雷霆之王]]};
arRealms['cn']['雷霆号角'] = {locale = [[zh_CN]],name = [[雷霆号角]]};
arRealms['cn']['霍格'] = {locale = [[zh_CN]],name = [[霍格]]};
arRealms['cn']['霜之哀伤'] = {locale = [[zh_CN]],name = [[霜之哀伤]]};
arRealms['cn']['霜狼'] = {locale = [[zh_CN]],name = [[霜狼]]};
arRealms['cn']['风暴之怒'] = {locale = [[zh_CN]],name = [[风暴之怒]]};
arRealms['cn']['风暴之眼'] = {locale = [[zh_CN]],name = [[风暴之眼]]};
arRealms['cn']['风暴之鳞'] = {locale = [[zh_CN]],name = [[风暴之鳞]]};
arRealms['cn']['风暴峭壁'] = {locale = [[zh_CN]],name = [[风暴峭壁]]};
arRealms['cn']['风行者'] = {locale = [[zh_CN]],name = [[风行者]]};
arRealms['cn']['鬼雾峰'] = {locale = [[zh_CN]],name = [[鬼雾峰]]};
arRealms['cn']['鲜血熔炉'] = {locale = [[zh_CN]],name = [[鲜血熔炉]]};
arRealms['cn']['鹰巢山'] = {locale = [[zh_CN]],name = [[鹰巢山]]};
arRealms['cn']['麦姆'] = {locale = [[zh_CN]],name = [[麦姆]]};
arRealms['cn']['麦维影歌'] = {locale = [[zh_CN]],name = [[麦维影歌]]};
arRealms['cn']['麦迪文'] = {locale = [[zh_CN]],name = [[麦迪文]]};
arRealms['cn']['黄金之路'] = {locale = [[zh_CN]],name = [[黄金之路]]};
arRealms['cn']['黑手军团'] = {locale = [[zh_CN]],name = [[黑手军团]]};
arRealms['cn']['黑暗之矛'] = {locale = [[zh_CN]],name = [[黑暗之矛]]};
arRealms['cn']['黑暗之门'] = {locale = [[zh_CN]],name = [[黑暗之门]]};
arRealms['cn']['黑暗虚空'] = {locale = [[zh_CN]],name = [[黑暗虚空]]};
arRealms['cn']['黑暗魅影'] = {locale = [[zh_CN]],name = [[黑暗魅影]]};
arRealms['cn']['黑石尖塔'] = {locale = [[zh_CN]],name = [[黑石尖塔]]};
arRealms['cn']['黑翼之巢'] = {locale = [[zh_CN]],name = [[黑翼之巢]]};
arRealms['cn']['黑铁'] = {locale = [[zh_CN]],name = [[黑铁]]};
arRealms['cn']['黑锋哨站'] = {locale = [[zh_CN]],name = [[黑锋哨站]]};
arRealms['cn']['黑龙军团'] = {locale = [[zh_CN]],name = [[黑龙军团]]};
arRealms['cn']['龙骨平原'] = {locale = [[zh_CN]],name = [[龙骨平原]]};

local GetLangByLocale = function( realmLocale )
	if realmLocale:len() < 2 then
		return false
	else
		return realmLocale:sub(1,2)
	end
end

local GetRegionByLocale = function( realmLocale )
	-- see http://us.battle.net/wow/en/forum/topic/2878487920
	if realmLocale == "en_US" or 
		realmLocale == "es_MX" or 
		realmLocale == "pt_BR" 
			then
		return "us"
	elseif 	realmLocale == "en_GB" or 
			realmLocale == "es_ES" or
			realmLocale == "fr_FR" or 
			realmLocale == "ru_RU" or 
			realmLocale == "de_DE" or 
			realmLocale == "pt_PT" 
				then
		return "eu"
	elseif realmLocale == "ko_KR" then
		return "kr"
	elseif realmLocale == "zh_TW" then
		return "tw"
	elseif realmLocale == "zh_CN" then
		return "cn"
	else
		return false
	end
end

local GetURLParams = function( realmLocale )
	region = GetRegionByLocale(realmLocale)
	lang = GetLangByLocale(realmLocale)

	return region, lang
end

local PutInEditbox = function(txt)
	local frame = _G["BCM_URLCopyFrame"]
	if frame then
		frame.editBox:SetText(txt)
		frame.editBox:HighlightText()
		frame:Show()
	else
		local editbox = LAST_ACTIVE_CHAT_EDIT_BOX
		editbox:SetText(txt)
		editbox:HighlightText()
		editbox:Show()
		editbox:SetFocus()
	end
end

-- Dropdown menu link
hooksecurefunc("UnitPopup_OnClick", function(self)
	local dropdownFrame = UIDROPDOWNMENU_INIT_MENU
	local name = dropdownFrame.name
	if name and self.value == "ARMORYLINK" then
		local defaultRealmName = GetRealmName()
		local realmLocale = GetLocale()
		realmLocale = realmLocale:sub(1,2)..'_'..realmLocale:sub(3,4)
		defaultRealmName = defaultRealmName:gsub("'", "")
		defaultRealmName = defaultRealmName:gsub("-", "")
		defaultRealmName = defaultRealmName:gsub(" ", "")

		local region = GetRegionByLocale(realmLocale)
		local realm = dropdownFrame.server

		if not realm or realm == nil or realm == '' then
			realm = defaultRealmName
		end

		arRealm = arRealms[region][realm]

		if arRealm then
			local region, lang = GetURLParams(arRealm.locale);

			local domain = '';
			if region == 'cn' then
				domain = 'www.battlenet.com.cn';
			else
				domain = region..'.battle.net';
			end

			linkurl = 'http://'..domain..'/wow/'..lang..'/character/'..arRealm.name..'/'..name..'/advanced'
			PutInEditbox(linkurl)
			return
		else
			print("|cFFFFFF00".. arStrings.unsupportedRealm .."|r")
			return
		end
	end
end)

UnitPopupButtons["ARMORYLINK"] = {text = arStrings.armoryLink, dist = 0, func = UnitPopup_OnClick}
table.insert(UnitPopupMenus["FRIEND"], #UnitPopupMenus["FRIEND"] - 1, "ARMORYLINK")
table.insert(UnitPopupMenus["PARTY"], #UnitPopupMenus["PARTY"] - 1, "ARMORYLINK")
table.insert(UnitPopupMenus["RAID"], #UnitPopupMenus["RAID"] - 1, "ARMORYLINK")
table.insert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"] - 1, "ARMORYLINK")

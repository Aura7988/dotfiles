const {
	aceVimMap,
	mapkey,
	imap,
	iunmap,
	imapkey,
	getClickableElements,
	vmapkey,
	map,
	unmap,
	cmap,
	addSearchAlias,
	removeSearchAlias,
	tabOpenLink,
	readText,
	Clipboard,
	Front,
	Hints,
	Visual,
	RUNTIME,
} = api;

Hints.setCharacters('hjklasdfgqwertzxcvbyuiopnm');
settings.omnibarMaxResults = 33;
settings.tabsThreshold = 12;
settings.scrollStepSize = 159;
settings.hintAlign = "left";
settings.defaultSearchEngine = "gg";
settings.nextLinkRegex = /^((N|n)ext|newer|>>?|»|(下|后)一?(页|封|张|篇))$/i
settings.prevLinkRegex = /^((P|p)rev(ious)?|older|<<?|«|(上|前)一?(页|封|张|篇))$/i

// map('t', 'T'); // opened tabs
map('e', 'go'); // open in the current tab
map(',h', 'H');
map('H', 'h');
map('L', 'l');
map('h', 'S'); // backward
map('l', 'D'); // forward
map('<Ctrl-k>', 'E'); // go one tab left
map('<Ctrl-j>', 'R'); // go one tab right
map(',a', 'g0'); // go to first tab
map(',e', 'g$'); // go to last tab
map(',k', 'gxt'); // close left tab
map(',j', 'gxT'); // close right tab
map('<Ctrl-d>', 'x'); // close current tab
unmap('x');
map('<Ctrl-u>', 'X'); // restore current tab
map('<Ctrl-[>', '<Esc>');
map('<Ctrl-f>', 'P');
map('<Ctrl-b>', 'U');
mapkey('p', "Open the clipboard's text in current tab", function() {
	navigator.clipboard.readText().then(
		text => {
			if (text.startsWith("http://") || text.startsWith("https://")) {
				window.location = text;
			} else {
				window.location = text = "https://www.google.com/search?q=" + text;
			}
		}
	);
});
mapkey('P', "Open the clipboard's text in new tab", function() {
	navigator.clipboard.readText().then(
		text => {
			if (text.startsWith("http://") || text.startsWith("https://")) {
				tabOpenLink(text);
			} else {
				tabOpenLink("https://www.google.com/search?q=" + text);
			}
		}
	);
});

iunmap(":");
cmap('<Ctrl-;>', '<Ctrl-.>');

removeSearchAlias('e');
removeSearchAlias('g');
// removeSearchAlias('h');
removeSearchAlias('s');
removeSearchAlias('w');
addSearchAlias('gg', 'google', 'https://www.google.com/search?q=');
addSearchAlias('gh', 'github', 'https://github.com/search?q=');
addSearchAlias('jd', 'jd', 'http://search.jd.com/Search?keyword=');
addSearchAlias('so', 'stackoverflow', 'https://stackoverflow.com/search?q=');
addSearchAlias('se', 'sogou-en', 'https://fanyi.sogou.com/text?keyword={0}&transfrom=auto&transto=en&model=general');
addSearchAlias('sz', 'sogou-zh', 'https://fanyi.sogou.com/text?keyword={0}&transfrom=auto&transto=zh-CHS&model=general');
addSearchAlias('we', 'wiki-en', 'https://en.wikipedia.org/wiki/');
addSearchAlias('wz', 'wiki-zh', 'https://zh.wikipedia.org/wiki/');

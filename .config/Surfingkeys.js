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
//settings.defaultSearchEngine = "gg";
settings.nextLinkRegex = /^((N|n)ext|newer|>>?|»|(下|后)一?(页|封|张|篇))$/i
settings.prevLinkRegex = /^((P|p)rev(ious)?|older|<<?|«|(上|前)一?(页|封|张|篇))$/i

map('e', 'go'); // open in the current tab
map(',t', 'H');
map(',h', 'oh');
mapkey('oh', '打开Github搜索栏', () => {
	Front.openOmnibar({type: "SearchEngine", extra: "h"});
});
map('<Ctrl-f>', 'P');
map('<Ctrl-b>', 'U');
mapkey('p', "打开选中文本或剪切板内容", function() {
	Clipboard.read(function(response) {
		var query = window.getSelection().toString() || response.data;
		Front.openOmnibar({type: "URLs", pref: query, tabbed: false});
	});
});
mapkey('P', "在新标签页打开选中文本或剪切板内容", function() {
	Clipboard.read(function(response) {
		var query = window.getSelection().toString() || response.data;
		Front.openOmnibar({type: "URLs", pref: query});
	});
});
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
iunmap(":");
cmap('<Ctrl-;>', '<Ctrl-.>');

addSearchAlias('a', 'wolframalpha', 'http://www.wolframalpha.com/input/?i=');
addSearchAlias('n', 'hackernews', 'https://hn.algolia.com/?query=');
addSearchAlias('o', 'onelook', 'http://onelook.com/?w=');
addSearchAlias('v', 'vimwiki', 'https://vim.fandom.com/wiki/Special:Search?query=');
addSearchAlias('z', 'wiki-zh', 'https://zh.wikipedia.org/wiki/');

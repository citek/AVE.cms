function cp_code(v, feldname, form) {
	if (document.selection) {
		var str = document.selection.createRange().text;
		document.getElementById(feldname).focus();
		var sel = document.selection.createRange();
		sel.text = "<" + v + ">" + str + "</" + v + ">";
		return;
	}
	else if (document.getElementById && !document.all) {
		var txtarea = document.forms[form].elements[feldname];
		var selLength = txtarea.textLength;
		var selStart = txtarea.selectionStart;
		var selEnd = txtarea.selectionEnd;
		if (selEnd == 1 || selEnd == 2)
		selEnd = selLength;
		var s1 = (txtarea.value).substring(0,selStart);
		var s2 = (txtarea.value).substring(selStart, selEnd)
		var s3 = (txtarea.value).substring(selEnd, selLength);
		txtarea.value = s1 + '<' + v + '>' + s2 + '</' + v + '>' + s3;
		return;
	}
	else {
		cp_insert('<' + v + '></' + v + '> ');
	}
}

function cp_tag(v, feldname, form) {
	if (document.selection) {
		var str = document.selection.createRange().text;
		document.getElementById(feldname).focus();
		var sel = document.selection.createRange();
		sel.text = "[" + v + "]" + str + "[/" + v + "]";
		return;
	}
	else if (document.getElementById && !document.all) {
		var txtarea = document.forms[form].elements[feldname];
		var selLength = txtarea.textLength;
		var selStart = txtarea.selectionStart;
		var selEnd = txtarea.selectionEnd;
		if (selEnd == 1 || selEnd == 2)
		selEnd = selLength;
		var s1 = (txtarea.value).substring(0,selStart);
		var s2 = (txtarea.value).substring(selStart, selEnd)
		var s3 = (txtarea.value).substring(selEnd, selLength);
		txtarea.value = s1 + '[' + v + ']' + s2 + '[/' + v + ']' + s3;
		return;
	}
	else {
		cp_insert('[' + v + '][/' + v + '] ');
	}
}

function cp_insert(what,feldname, form) {
	if (document.getElementById(feldname).createTextRange) {
		document.getElementById(feldname).focus();
		document.selection.createRange().duplicate().text = what;
	}
	else if (document.getElementById && !document.all) {
		var tarea = document.forms[form].elements[feldname];
		var selEnd = tarea.selectionEnd;
		var txtLen = tarea.value.length;
		var txtbefore = tarea.value.substring(0,selEnd);
		var txtafter =  tarea.value.substring(selEnd, txtLen);
		tarea.value = txtbefore + what + txtafter;
	}
	else {
		document.entryform.text.value += what;
	}
}

function browse_uploads(target, width, height, scrollbar) {
	if (typeof width=='undefined' || width=='') var width = Math.min(screen.width, 950);
	if (typeof height=='undefined' || height=='') var height = Math.min(screen.height, 750);
	if (typeof scrollbar=='undefined') var scrollbar=0;
	var targetVal = document.getElementById(target).value;
	var left = ( screen.width - width ) / 2;
	var top = ( screen.height - height ) / 2;
	window.open('browser.php?typ=bild&mode=fck&target='+target+'&tval='+targetVal,'imgpop','left='+left+',top='+top+',width='+width+',height='+height+',scrollbars='+scrollbar+',resizable=1');
}

function windowOpen(url, width, height, scrollbar, winname) {
	if (typeof width=='undefined' || width=='') var width = screen.width * 0.8;
	if (typeof height=='undefined' || height=='') var height = screen.height * 0.8;
	if (typeof scrollbar=='undefined') var scrollbar=1;
	if (typeof winname=='undefined') var winname='pop';
	var left = ( screen.width - width ) / 2;
	var top = ( screen.height - height ) / 2;
	window.open(url,winname,'left='+left+',top='+top+',width='+width+',height='+height+',scrollbars='+scrollbar+',resizable=1').focus();
}

function cp_imagepop(url, width, height, scrollbar) {
	if (typeof width=='undefined' || width=='') var width = screen.width * 0.8;
	if (typeof height=='undefined' || height=='') var height = screen.height * 0.8;
	if (typeof scrollbar=='undefined') var scrollbar=1;
	var left = ( screen.width - width ) / 2;
	var top = ( screen.height - height ) / 2;
	window.open('browser.php?typ=bild&mode=fck&target='+url+'','imgpop','left='+left+',top='+top+',width='+width+',height='+height+',scrollbars='+scrollbar+',resizable=1,center=yes');
}

function cp_pop(url, width, height, scrollbar, winname) {
	if (typeof width=='undefined' || width=='') var width = screen.width * 0.8;
	if (typeof height=='undefined' || height=='') var height = screen.height * 0.8;
	if (typeof scrollbar=='undefined') var scrollbar=1;
	if (typeof winname=='undefined') var winname='pop';
	var left = ( screen.width - width ) / 2;
	var top = ( screen.height - height ) / 2;
	window.open(url,winname,'left='+left+',top='+top+',width='+width+',height='+height+',scrollbars='+scrollbar+',resizable=1').focus();
}
function confirmDelete(){
    $(".ConfirmDelete").click(function(e){
		e.preventDefault();
		var href = $(this).attr('href');
		var title = $(this).attr('dir');
		var confirm = $(this).attr('name');
		jConfirm(
				confirm,
				title,
				function(b){
					if (b){
						$.alerts._overlay('show');
						window.location = href;
					}
				}
			);
	});
}
$(document).ready(function(){

	confirmDelete();

    //===== Преобразование форм =====//
    $("form.mainForm").jqTransform({imgPath:"../images"});

    //===== Выход =====//
	$(".ConfirmLogOut").click( function(e) {
		e.preventDefault();
		var href = $(this).attr('href');
		var title = "Выход из панели управления";
		var confirm = "Вы уверены, что хотите выйти?";
		jConfirm(
				confirm,
				title,
				function(b){
					if (b){
                        window.location = href;
            		}
				}
			);
	});

    //===== Окно очистки кэша =====//
	$(".clearCache").click( function(e) {
		e.preventDefault();
		var title = "Очистка кэша";
		var confirm = "Вы уверены, что хотите очистить кэш?";
		jConfirm(
				confirm,
				title,
				function(b){
					if (b){
                        $.alerts._overlay('hide');
                        $.alerts._overlay('show');
            		    $.post(ave_path+'admin/index.php?do=settings&sub=clearcache&ajax=run&templateCacheClear=1&templateCompiledTemplateClear=1&moduleCacheClear=1&sqlCacheClear=1', function(){
                            $.alerts._overlay('hide');
                            $.jGrowl('Кэш очищен');
                            $('#cachesize').html('0 Kb');
							$('.cachesize').html('0 Kb');
                        });
            		}
				}
			);
	});
    //===== Окно очистки кэша + Сессий =====//
	$(".clearCacheSess").click( function(e) {
		e.preventDefault();
		var title = "Очистка кэша";
		var confirm = "Вы уверены, что хотите очистить кэш?";
		jConfirm(
				confirm,
				title,
				function(b){
					if (b){
                        $.alerts._overlay('hide');
                        $.alerts._overlay('show');
            		    $.post(ave_path+'admin/index.php?do=settings&sub=clearcache&ajax=run&templateCacheClear=1&templateCompiledTemplateClear=1&moduleCacheClear=1&sqlCacheClear=1&sessionClear=1', function(){
                            $.alerts._overlay('hide');
                            $.jGrowl('Кэш очищен');
                        });
            		}
				}
			);
	});

	//===== ToTop =====//
	$().UItoTop({ easingType: 'easeOutQuart' });


	//===== UI dialog =====//
	$( "#dialog-message" ).dialog({
		autoOpen: false,
		modal: true,
		buttons: {
			Ok: function() {
				$( this ).dialog( "close" );
			}
		}
	});

	$( "#opener" ).click(function() {
		$( "#dialog-message" ).dialog( "open" );
		return false;
	});


    //===== Выпадашка в меню =====//
	$('.dd_modul').click(function () {
		$('ul.menu_modul').slideToggle(100);
	});
	$(document).bind('click', function(e) {
	var $clicked = $(e.target);
	if (! $clicked.parents().hasClass("dd_modul"))
		$("ul.menu_modul").hide(10);
	});

    //===== Выпадашка в меню =====//
	$('.dd_settings').click(function () {
		$('ul.menu_settings').slideToggle(100);
	});
	$(document).bind('click', function(e) {
	var $clicked = $(e.target);
	if (! $clicked.parents().hasClass("dd_settings"))
		$("ul.menu_settings").hide(10);
	});

    //===== Выпадашка в меню =====//
	$('.dd_add').click(function () {
		$('ul.menu_add').slideToggle(100);
	});
	$(document).bind('click', function(e) {
	var $clicked = $(e.target);
	if (! $clicked.parents().hasClass("dd_add"))
		$("ul.menu_add").hide(10);
	});

    //===== Выпадашка в меню =====//
	$('.dd_page').click(function () {
		$('ul.menu_page').slideToggle(100);
	});
	$(document).bind('click', function(e) {
	var $clicked = $(e.target);
	if (! $clicked.parents().hasClass("dd_page"))
		$("ul.menu_page").hide(10);
	});

    //===== Выпадашка в меню =====//
	$('.dd_login').click(function () {
		$('ul.menu_login').slideToggle(100);
	});
	$(document).bind('click', function(e) {
	var $clicked = $(e.target);
	if (! $clicked.parents().hasClass("dd_login"))
		$("ul.menu_login").hide(10);
	});

	//===== Custom single file input =====//
	$("input.fileInput").filestyle({
		imageheight : 26,
		imagewidth : 98,
		width : 296
	});


	//===== Dynamic Tables =====//
	oTable = $('#dinamTable').dataTable({
		"bJQueryUI": true,
		"sPaginationType": "full_numbers",
        "aaSorting": [[ 0, "desc" ]],
		"sDom": '<""f>t<"F"lp>'
	});


	//===== Placeholder for all browsers =====//
	$('input[placeholder], textarea[placeholder]').placeholder();

	//===== Information boxes =====//
	$(".hideit").click(function() {
		$(this).fadeOut(400);
	});


	//===== Tabs =====//
	$.fn.simpleTabs = function(){

		//Default Action
		$(this).find(".tab_content").hide(); //Hide all content
		$(this).find("ul.tabs li:first").addClass("activeTab").show(); //Activate first tab
		$(this).find(".tab_content:first").show(); //Show first tab content

		//On Click Event
		$("ul.tabs li").click(function() {
			$(this).parent().parent().find("ul.tabs li").removeClass("activeTab"); //Remove any "active" class
			$(this).addClass("activeTab"); //Add "active" class to selected tab
			$(this).parent().parent().find(".tab_content").hide(); //Hide all tab content
			var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
			$(activeTab).show(); //Fade in the active content
			return false;
		});

	};//end function

	$("div[class^='widget']").simpleTabs(); //Run function on any div with class name of "Simple Tabs"


	//===== Tooltip =====//
	$('.topleftDir').tipsy({fade: false, gravity: 'se'});
	$('.toprightDir').tipsy({fade: false, gravity: 'sw'});
	$('.leftDir').tipsy({fade: false, gravity: 'e'});
	$('.rightDir').tipsy({fade: false, gravity: 'w'});
	$('.topDir').tipsy({fade: false, gravity: 's'});
	$('.botDir').tipsy({fade: false, gravity: 'n'});

	//===== Collapsible elements management =====//
	$('.opened').collapsible({
		defaultOpen: 'opened',
		cssOpen: 'inactive',
		cssClose: 'normal',
		cookieName: 'opened',
		cookieOptions: {
	        expires: 7,
			domain: ''
    	},
		speed: 200
	});

	$('.closed').collapsible({
		defaultOpen: '',
		cssOpen: 'inactive',
		cssClose: 'normal',
		cookieName: 'closed',
		cookieOptions: {
	        expires: 7,
			domain: ''
    	},
		speed: 200
	});

	//===== Date & Time Pickers =====//
	$.datepicker.regional['ru'] = {
		closeText: 'Закрыть',
		prevText: '<Пред',
		nextText: 'След>',
		currentText: 'Сегодня',
		monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь',
		'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
		monthNamesShort: ['Янв','Фев','Мар','Апр','Май','Июн',
		'Июл','Авг','Сен','Окт','Ноя','Дек'],
		dayNames: ['воскресенье','понедельник','вторник','среда','четверг','пятница','суббота'],
		dayNamesShort: ['вск','пнд','втр','срд','чтв','птн','сбт'],
		dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
		weekHeader: 'Не',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''
	};
	$.datepicker.setDefaults($.datepicker.regional['ru']);

	$.timepicker.regional['ru'] = {
		timeOnlyTitle: 'Выберите время',
		timeText: 'Время',
		hourText: 'Часы',
		minuteText: 'Минуты',
		secondText: 'Секунды',
		millisecText: 'миллисекунды',
		currentText: 'Теперь',
		closeText: 'Закрыть',
		ampm: false
	};
	$.timepicker.setDefaults($.timepicker.regional['ru']);
});

(function ($) {
    $.fn.extend({
        limit: function (limit, element) {
            var interval, f;
            var self = $(this);
            $(this).focus(function () {
                interval = window.setInterval(substring, 100)
            });
            $(this).blur(function () {
                clearInterval(interval);
                substring()
            });
            substringFunction = "function substring(){ var val = $(self).val();var length = val.length;if(length > limit){$(self).val($(self).val().substring(0,limit));}";
            if (typeof element != 'undefined') substringFunction += "if($(element).html() != limit-length){$(element).html((limit-length<=0)?'0':limit-length);}";
            substringFunction += "}";
            eval(substringFunction);
            substring()
        }
    })
});
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 암호화 -->
<%@ include file="/WEB-INF/common/head.jsp" %>

<meta charset="UTF-8">
<title>main</title>
</head>
<script type="text/javascript">
    

	
    $(document).ready(function() {
        
        // 탭 li 선언
        var tabTemplate = "<li><a href='<%="#"%>{href}'><%="#"%>{label}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>";
        // 탭 선언
        var tabs = $( "#tabs" ).tabs();
        
        // documents의 a태그들 중 원하는 a태그 클릭 했을때 실행 
        $("#documents a").click(function() {
            // 현재 눌린 a 태그 가져오기
            var link = $(this);
            // tabs_id 선언
            var tabs_id = "tabs-" + $(link).attr("id");
            // find_id 선언
            var find_id = $("[id= " + tabs_id + "]").attr("id");
            // tab_id 선언
            var tab_id = "#" + tabs_id;
            // a태그에 해당하는 탭이 열려 있을 경우
            if(find_id == tabs_id){
                // 열려있는 탭으로 이동
                tabs.tabs("option","active", id2Index("#tabs",tab_id));
            // 아닐경우
            }else{
                // 탭을 추가
                addTab(link);
            }
        });
        
        // 선택한 documents a 태그의 해당하는 tab index 찾기
        function id2Index(tabsId, srcId){
            // index 값 -1로 설정
            var index = -1;
            // i 값 선언, tbH : 해당하는 탭의 a 태그 찾기
            var i = 0, tbH = $(tabsId).find("li a");
            // tbH 길이 선언
            var lntb = tbH.length;
            // lntb가 0보다 클경우
            if(lntb>0){
                for(i=0;i<lntb;i++){
                    o=tbH[i];
                    if(o.href.search(srcId)>0){
                        index = i;
                    }
                }
            }
            // index값 리턴
            return index;
        }
        
        // 해당 탭 지우기
        tabs.on( "click", "span.ui-icon-close", function() {
            var panelId = $( this ).closest( "li" ).remove().attr( "aria-controls" );
            // 해당하는 탭 제거
            $( "#" + panelId ).remove();
            // 탭 refresh
            tabs.tabs( "refresh" );
          });
        // 탭 추가
        function addTab(link){
            // 탭 라벨 선언
            var label = $(link).text();
            // id 값을 tabs-? 로 선언
            var id = "tabs-" + $(link).attr("id");
            // rel : link의 속성 중 rel을 찾는다 (ajax로 탭에 보여줄 내용을 가져올 html의 주소가 들어간다)
            var rel = $(link).attr("rel");
            // li replace
            var li = $( tabTemplate.replace( /#\{href\}/g, "#" + id ).replace( /#\{label\}/g, label ) );
            // tab내용 선언
            var tabContentHtml = "";
            // ajax 실행
            $.ajax({
                type : "GET",
                // controller로 갈 url
                url : rel,
                // tabContentHtml이 전역변수이기 떄문에 false값을 준다
                async:false,
                // 받아올 데이터타입은 html
                dataType : "html",
                success : function(data){
                    // tabContentHtml에 넘어온 data값을 준다 결국 jsp 파일을 html형식으로 tabContentHtml이 들어가는 것
                    tabContentHtml = data;
                }
            });
            // 탭의 ui-tabs-nav 찾아서 li를 append 시킨다
            tabs.find(".ui-tabs-nav").append(li);
            // 추가된 탭의 내용을 삽입
            tabs.find(".tabs-list").append( "<div id='" + id + "'><p>" + tabContentHtml + "</p></div>" );
            // 탭 새로고침
            tabs.tabs( "refresh" );
            // 생성 된 탭으로 바로 가게 한다.
            tabs.tabs( "option", "active", $("#tab_header").index());
        }
    });
        
</script>


<body>
<div id="root" class="root">
	<div id="main-menu" class="mainMenu">
		<span class="mainmenu h1">main메뉴</span>
	</div>
	<div id=left-menu class="left-menu" style="width:120px;float:left">
	    <h2>트리메뉴</h2>
	    <ul id="documents">
	        <li><a href="#" id = "1" rel="hello" title="This is the content of Document1">hello</a></li>
	        <li><a href="#" id = "2" rel="readPage2" title="This is the content of Document2">탭2</a></li>
	        <li><a href="#" id = "3" rel="readPage3" title="This is the content of Document3">탭3</a></li>
	        <li><a href="#" id = "4" rel="readPage4" title="This is the content of Document4">탭4</a></li>
	        <li><a href="#" id = "5" rel="readPage5" title="This is the content of Document5">탭5</a></li>
	    </ul>
	</div>
	<div id="main-contents">
		<div id="tabs" class="tab-document" style="width:1000px;float:left">
		  <div class="tabs-list" style="height:700px">
			  <div id="tabs-0">
			    <p>탭 구현</p>
			  </div>
		  </div>
		  <ul>
		    <li><a href="#tabs-0">main</a> </li>
		  </ul>
		</div>
	</div>
</div>



</body>
</html>
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


(function(){
    var e;e=function(){
        function e(){
            this.options_index=0;this.parsed=[]
            }e.prototype.add_node=function(e){
            if(e.nodeName==="OPTGROUP"){
                return this.add_group(e)
                }else{
                return this.add_option(e)
                }
            };e.prototype.add_group=function(e){
            var t,n,r,i,s,o;t=this.parsed.length;this.parsed.push({
                array_index:t,
                group:true,
                label:e.label,
                children:0,
                disabled:e.disabled
                });s=e.childNodes;o=[];for(r=0,i=s.length;r<i;r++){
                n=s[r];o.push(this.add_option(n,t,e.disabled))
                }return o
            };e.prototype.add_option=function(e,t,n){
            if(e.nodeName==="OPTION"){
                if(e.text!==""){
                    if(t!=null)this.parsed[t].children+=1;this.parsed.push({
                        array_index:this.parsed.length,
                        options_index:this.options_index,
                        value:e.value,
                        text:e.text,
                        html:e.innerHTML,
                        selected:e.selected,
                        disabled:n===true?n:e.disabled,
                        group_array_index:t,
                        classes:e.className,
                        style:e.style.cssText
                        })
                    }else{
                    this.parsed.push({
                        array_index:this.parsed.length,
                        options_index:this.options_index,
                        empty:true
                    })
                    }return this.options_index+=1
                }
            };return e
        }();e.select_to_array=function(t){
        var n,r,i,s,o;r=new e;o=t.childNodes;for(i=0,s=o.length;i<s;i++){
            n=o[i];r.add_node(n)
            }return r.parsed
        };this.SelectParser=e
    }).call(this);(function(){
    var e,t;t=this;e=function(){
        function e(e,t){
            this.form_field=e;this.options=t!=null?t:{};this.set_default_values();this.is_multiple=this.form_field.multiple;this.default_text_default=this.is_multiple?"":"";this.setup();this.set_up_html();this.register_observers();this.finish_setup()
            }e.prototype.set_default_values=function(){
            var e=this;this.click_test_action=function(t){
                return e.test_active_click(t)
                };this.activate_action=function(t){
                return e.activate_field(t)
                };this.active_field=false;this.mouse_on_container=false;this.results_showing=false;this.result_highlighted=null;this.result_single_selected=null;this.allow_single_deselect=this.options.allow_single_deselect!=null&&this.form_field.options[0]!=null&&this.form_field.options[0].text===""?this.options.allow_single_deselect:false;this.disable_search_threshold=this.options.disable_search_threshold||0;this.choices=0;return this.results_none_found=this.options.no_results_text||"No results match"
            };e.prototype.mouse_enter=function(){
            return this.mouse_on_container=true
            };e.prototype.mouse_leave=function(){
            return this.mouse_on_container=false
            };e.prototype.input_focus=function(e){
            var t=this;if(!this.active_field){
                return setTimeout(function(){
                    return t.container_mousedown()
                    },50)
                }
            };e.prototype.input_blur=function(e){
            var t=this;if(!this.mouse_on_container){
                this.active_field=false;return setTimeout(function(){
                    return t.blur_test()
                    },100)
                }
            };e.prototype.result_add_option=function(e){
            var t,n;if(!e.disabled){
                e.dom_id=this.container_id+"_o_"+e.array_index;t=e.selected&&this.is_multiple?[]:["active-result"];if(e.selected)t.push("result-selected");if(e.group_array_index!=null)t.push("group-option");if(e.classes!=="")t.push(e.classes);n=e.style.cssText!==""?' style="'+e.style+'"':"";return'<li id="'+e.dom_id+'" class="'+t.join(" ")+'"'+n+">"+e.html+"</li>"
                }else{
                return""
                }
            };e.prototype.results_update_field=function(){
            this.result_clear_highlight();this.result_single_selected=null;return this.results_build()
            };e.prototype.results_toggle=function(){
            if(this.results_showing){
                return this.results_hide()
                }else{
                return this.results_show()
                }
            };e.prototype.results_search=function(e){
            if(this.results_showing){
                return this.winnow_results()
                }else{
                return this.results_show()
                }
            };e.prototype.keyup_checker=function(e){
            var t,n;t=(n=e.which)!=null?n:e.keyCode;this.search_field_scale();switch(t){
                case 8:if(this.is_multiple&&this.backstroke_length<1&&this.choices>0){
                    return this.keydown_backstroke()
                    }else if(!this.pending_backstroke){
                    this.result_clear_highlight();return this.results_search()
                    }break;case 13:e.preventDefault();if(this.results_showing)return this.result_select(e);break;case 27:if(this.results_showing)this.results_hide();return true;case 9:case 38:case 40:case 16:case 91:case 17:break;default:return this.results_search()
                    }
            };e.prototype.generate_field_id=function(){
            var e;e=this.generate_random_id();this.form_field.id=e;return e
            };e.prototype.generate_random_char=function(){
            var e,t,n;e="0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZ";n=Math.floor(Math.random()*e.length);return t=e.substring(n,n+1)
            };return e
        }();t.AbstractChosen=e
    }).call(this);(function(){
    var e,t,n,r,i=Object.prototype.hasOwnProperty,s=function(e,t){
        function r(){
            this.constructor=e
            }for(var n in t){
            if(i.call(t,n))e[n]=t[n]
                }r.prototype=t.prototype;e.prototype=new r;e.__super__=t.prototype;return e
        };r=this;e=jQuery;e.fn.extend({
        chosen:function(n){
            if(e.browser.msie&&(e.browser.version==="6.0"||e.browser.version==="7.0")){
                return this
                }return e(this).each(function(r){
                if(!e(this).hasClass("chzn-done"))return new t(this,n)
                    })
            }
        });t=function(t){
        function i(){
            i.__super__.constructor.apply(this,arguments)
            }s(i,t);i.prototype.setup=function(){
            this.form_field_jq=e(this.form_field);return this.is_rtl=this.form_field_jq.hasClass("chzn-rtl")
            };i.prototype.finish_setup=function(){
            return this.form_field_jq.addClass("chzn-done")
            };i.prototype.set_up_html=function(){
            var t,r,i,s;this.container_id=this.form_field.id.length?this.form_field.id.replace(/(:|\.)/g,"_"):this.generate_field_id();this.container_id+="_chzn";this.f_width=this.form_field_jq.outerWidth();this.default_text=this.form_field_jq.data("placeholder")?this.form_field_jq.data("placeholder"):this.default_text_default;t=e("<div />",{
                id:this.container_id,
                "class":"chzn-container"+(this.is_rtl?" chzn-rtl":""),
                style:"width: "+this.f_width+"px;"
                });if(this.is_multiple){
                t.html('<ul class="chzn-choices"><li class="search-field"><input type="text" value="'+this.default_text+'" class="default" autocomplete="off" style="width:25px;" /></li></ul><div class="chzn-drop" style="left:-9000px;"><ul class="chzn-results"></ul></div>')
                }else{
                t.html('<a href="javascript:void(0)" class="chzn-single"><span>'+this.default_text+'</span><div><b></b></div></a><div class="chzn-drop" style="left:-9000px;"><div class="chzn-search"><input type="text" autocomplete="off" /></div><ul class="chzn-results"></ul></div>')
                }this.form_field_jq.hide().after(t);this.container=e("#"+this.container_id);this.container.addClass("chzn-container-"+(this.is_multiple?"multi":"single"));this.dropdown=this.container.find("div.chzn-drop").first();r=this.container.height();i=this.f_width-n(this.dropdown);this.dropdown.css({
                width:i+"px",
                top:r+"px"
                });this.search_field=this.container.find("input").first();this.search_results=this.container.find("ul.chzn-results").first();this.search_field_scale();this.search_no_results=this.container.find("li.no-results").first();if(this.is_multiple){
                this.search_choices=this.container.find("ul.chzn-choices").first();this.search_container=this.container.find("li.search-field").first()
                }else{
                this.search_container=this.container.find("div.chzn-search").first();this.selected_item=this.container.find(".chzn-single").first();s=i-n(this.search_container)-n(this.search_field);this.search_field.css({
                    width:s+"px"
                    })
                }this.results_build();this.set_tab_index();return this.form_field_jq.trigger("liszt:ready",{
                chosen:this
            })
            };i.prototype.register_observers=function(){
            var e=this;this.container.mousedown(function(t){
                return e.container_mousedown(t)
                });this.container.mouseup(function(t){
                return e.container_mouseup(t)
                });this.container.mouseenter(function(t){
                return e.mouse_enter(t)
                });this.container.mouseleave(function(t){
                return e.mouse_leave(t)
                });this.search_results.mouseup(function(t){
                return e.search_results_mouseup(t)
                });this.search_results.mouseover(function(t){
                return e.search_results_mouseover(t)
                });this.search_results.mouseout(function(t){
                return e.search_results_mouseout(t)
                });this.form_field_jq.bind("liszt:updated",function(t){
                return e.results_update_field(t)
                });this.search_field.blur(function(t){
                return e.input_blur(t)
                });this.search_field.keyup(function(t){
                return e.keyup_checker(t)
                });this.search_field.keydown(function(t){
                return e.keydown_checker(t)
                });if(this.is_multiple){
                this.search_choices.click(function(t){
                    return e.choices_click(t)
                    });return this.search_field.focus(function(t){
                    return e.input_focus(t)
                    })
                }else{
                return this.container.click(function(e){
                    return e.preventDefault()
                    })
                }
            };i.prototype.search_field_disabled=function(){
            this.is_disabled=this.form_field_jq[0].disabled;if(this.is_disabled){
                this.container.addClass("chzn-disabled");this.search_field[0].disabled=true;if(!this.is_multiple){
                    this.selected_item.unbind("focus",this.activate_action)
                    }return this.close_field()
                }else{
                this.container.removeClass("chzn-disabled");this.search_field[0].disabled=false;if(!this.is_multiple){
                    return this.selected_item.bind("focus",this.activate_action)
                    }
                }
            };i.prototype.container_mousedown=function(t){
            var n;if(!this.is_disabled){
                n=t!=null?e(t.target).hasClass("search-choice-close"):false;if(t&&t.type==="mousedown")t.stopPropagation();if(!this.pending_destroy_click&&!n){
                    if(!this.active_field){
                        if(this.is_multiple)this.search_field.val("");e(document).click(this.click_test_action);this.results_show()
                        }else if(!this.is_multiple&&t&&(e(t.target)[0]===this.selected_item[0]||e(t.target).parents("a.chzn-single").length)){
                        t.preventDefault();this.results_toggle()
                        }return this.activate_field()
                    }else{
                    return this.pending_destroy_click=false
                    }
                }
            };i.prototype.container_mouseup=function(e){
            if(e.target.nodeName==="ABBR")return this.results_reset(e)
                };i.prototype.blur_test=function(e){
            if(!this.active_field&&this.container.hasClass("chzn-container-active")){
                return this.close_field()
                }
            };i.prototype.close_field=function(){
            e(document).unbind("click",this.click_test_action);if(!this.is_multiple){
                this.selected_item.attr("tabindex",this.search_field.attr("tabindex"));this.search_field.attr("tabindex",-1)
                }this.active_field=false;this.results_hide();this.container.removeClass("chzn-container-active");this.winnow_results_clear();this.clear_backstroke();this.show_search_field_default();return this.search_field_scale()
            };i.prototype.activate_field=function(){
            if(!this.is_multiple&&!this.active_field){
                this.search_field.attr("tabindex",this.selected_item.attr("tabindex"));this.selected_item.attr("tabindex",-1)
                }this.container.addClass("chzn-container-active");this.active_field=true;this.search_field.val(this.search_field.val());return this.search_field.focus()
            };i.prototype.test_active_click=function(t){
            if(e(t.target).parents("#"+this.container_id).length){
                return this.active_field=true
                }else{
                return this.close_field()
                }
            };i.prototype.results_build=function(){
            var e,t,n,i,s;this.parsing=true;this.results_data=r.SelectParser.select_to_array(this.form_field);if(this.is_multiple&&this.choices>0){
                this.search_choices.find("li.search-choice").remove();this.choices=0
                }else if(!this.is_multiple){
                this.selected_item.find("span").text(this.default_text);if(this.form_field.options.length<=this.disable_search_threshold){
                    this.container.addClass("chzn-container-single-nosearch")
                    }else{
                    this.container.removeClass("chzn-container-single-nosearch")
                    }
                }e="";s=this.results_data;for(n=0,i=s.length;n<i;n++){
                t=s[n];if(t.group){
                    e+=this.result_add_group(t)
                    }else if(!t.empty){
                    e+=this.result_add_option(t);if(t.selected&&this.is_multiple){
                        this.choice_build(t)
                        }else if(t.selected&&!this.is_multiple){
                        this.selected_item.find("span").text(t.text);if(this.allow_single_deselect)this.single_deselect_control_build()
                            }
                    }
                }this.search_field_disabled();this.show_search_field_default();this.search_field_scale();this.search_results.html(e);return this.parsing=false
            };i.prototype.result_add_group=function(t){
            if(!t.disabled){
                t.dom_id=this.container_id+"_g_"+t.array_index;return'<li id="'+t.dom_id+'" class="group-result">'+e("<div />").text(t.label).html()+"</li>"
                }else{
                return""
                }
            };i.prototype.result_do_highlight=function(e){
            var t,n,r,i,s;if(e.length){
                this.result_clear_highlight();this.result_highlight=e;this.result_highlight.addClass("highlighted");r=parseInt(this.search_results.css("maxHeight"),10);s=this.search_results.scrollTop();i=r+s;n=this.result_highlight.position().top+this.search_results.scrollTop();t=n+this.result_highlight.outerHeight();if(t>=i){
                    return this.search_results.scrollTop(t-r>0?t-r:0)
                    }else if(n<s){
                    return this.search_results.scrollTop(n)
                    }
                }
            };i.prototype.result_clear_highlight=function(){
            if(this.result_highlight)this.result_highlight.removeClass("highlighted");return this.result_highlight=null
            };i.prototype.results_show=function(){
            var e;if(!this.is_multiple){
                this.selected_item.addClass("chzn-single-with-drop");if(this.result_single_selected){
                    this.result_do_highlight(this.result_single_selected)
                    }
                }e=this.is_multiple?this.container.height():this.container.height()-1;this.dropdown.css({
                top:e+"px",
                left:0
            });this.results_showing=true;this.search_field.focus();this.search_field.val(this.search_field.val());return this.winnow_results()
            };i.prototype.results_hide=function(){
            if(!this.is_multiple){
                this.selected_item.removeClass("chzn-single-with-drop")
                }this.result_clear_highlight();this.dropdown.css({
                left:"-9000px"
            });return this.results_showing=false
            };i.prototype.set_tab_index=function(e){
            var t;if(this.form_field_jq.attr("tabindex")){
                t=this.form_field_jq.attr("tabindex");this.form_field_jq.attr("tabindex",-1);if(this.is_multiple){
                    return this.search_field.attr("tabindex",t)
                    }else{
                    this.selected_item.attr("tabindex",t);return this.search_field.attr("tabindex",-1)
                    }
                }
            };i.prototype.show_search_field_default=function(){
            if(this.is_multiple&&this.choices<1&&!this.active_field){
                this.search_field.val(this.default_text);return this.search_field.addClass("default")
                }else{
                this.search_field.val("");return this.search_field.removeClass("default")
                }
            };i.prototype.search_results_mouseup=function(t){
            var n;n=e(t.target).hasClass("active-result")?e(t.target):e(t.target).parents(".active-result").first();if(n.length){
                this.result_highlight=n;return this.result_select(t)
                }
            };i.prototype.search_results_mouseover=function(t){
            var n;n=e(t.target).hasClass("active-result")?e(t.target):e(t.target).parents(".active-result").first();if(n)return this.result_do_highlight(n)
                };i.prototype.search_results_mouseout=function(t){
            if(e(t.target).hasClass("active-result"||e(t.target).parents(".active-result").first())){
                return this.result_clear_highlight()
                }
            };i.prototype.choices_click=function(t){
            t.preventDefault();if(this.active_field&&!e(t.target).hasClass("search-choice"||e(t.target).parents(".search-choice").first)&&!this.results_showing){
                return this.results_show()
                }
            };i.prototype.choice_build=function(t){
            var n,r,i=this;n=this.container_id+"_c_"+t.array_index;this.choices+=1;this.search_container.before('<li class="search-choice" id="'+n+'"><span>'+t.html+'</span><a href="javascript:void(0)" class="search-choice-close" rel="'+t.array_index+'"></a></li>');r=e("#"+n).find("a").first();return r.click(function(e){
                return i.choice_destroy_link_click(e)
                })
            };i.prototype.choice_destroy_link_click=function(t){
            t.preventDefault();if(!this.is_disabled){
                this.pending_destroy_click=true;return this.choice_destroy(e(t.target))
                }else{
                return t.stopPropagation
                }
            };i.prototype.choice_destroy=function(e){
            this.choices-=1;this.show_search_field_default();if(this.is_multiple&&this.choices>0&&this.search_field.val().length<1){
                this.results_hide()
                }this.result_deselect(e.attr("rel"));return e.parents("li").first().remove()
            };i.prototype.results_reset=function(t){
            this.form_field.options[0].selected=true;this.selected_item.find("span").text(this.default_text);this.show_search_field_default();e(t.target).remove();this.form_field_jq.trigger("change");if(this.active_field)return this.results_hide()
                };i.prototype.result_select=function(e){
            var t,n,r,i;if(this.result_highlight){
                t=this.result_highlight;n=t.attr("id");this.result_clear_highlight();if(this.is_multiple){
                    this.result_deactivate(t)
                    }else{
                    this.search_results.find(".result-selected").removeClass("result-selected");this.result_single_selected=t
                    }t.addClass("result-selected");i=n.substr(n.lastIndexOf("_")+1);r=this.results_data[i];r.selected=true;this.form_field.options[r.options_index].selected=true;if(this.is_multiple){
                    this.choice_build(r)
                    }else{
                    this.selected_item.find("span").first().text(r.text);if(this.allow_single_deselect)this.single_deselect_control_build()
                        }if(!(e.metaKey&&this.is_multiple))this.results_hide();this.search_field.val("");this.form_field_jq.trigger("change");return this.search_field_scale()
                }
            };i.prototype.result_activate=function(e){
            return e.addClass("active-result")
            };i.prototype.result_deactivate=function(e){
            return e.removeClass("active-result")
            };i.prototype.result_deselect=function(t){
            var n,r;r=this.results_data[t];r.selected=false;this.form_field.options[r.options_index].selected=false;n=e("#"+this.container_id+"_o_"+t);n.removeClass("result-selected").addClass("active-result").show();this.result_clear_highlight();this.winnow_results();this.form_field_jq.trigger("change");return this.search_field_scale()
            };i.prototype.single_deselect_control_build=function(){
            if(this.allow_single_deselect&&this.selected_item.find("abbr").length<1){
                return this.selected_item.find("span").first().after('<abbr class="search-choice-close"></abbr>')
                }
            };i.prototype.winnow_results=function(){
            var t,n,r,i,s,o,u,a,f,l,c,h,p,d,v,m,g;this.no_results_clear();a=0;f=this.search_field.val()===this.default_text?"":e("<div/>").text(e.trim(this.search_field.val())).html();s=new RegExp("^"+f.replace(/[-[\]{}()*+?.,\\^$|#\s]/g,"\\$&"),"i");h=new RegExp(f.replace(/[-[\]{}()*+?.,\\^$|#\s]/g,"\\$&"),"i");g=this.results_data;for(p=0,v=g.length;p<v;p++){
                n=g[p];if(!n.disabled&&!n.empty){
                    if(n.group){
                        e("#"+n.dom_id).css("display","none")
                        }else if(!(this.is_multiple&&n.selected)){
                        t=false;u=n.dom_id;o=e("#"+u);if(s.test(n.html)){
                            t=true;a+=1
                            }else if(n.html.indexOf(" ")>=0||n.html.indexOf("[")===0){
                            i=n.html.replace(/\[|\]/g,"").split(" ");if(i.length){
                                for(d=0,m=i.length;d<m;d++){
                                    r=i[d];if(s.test(r)){
                                        t=true;a+=1
                                        }
                                    }
                                }
                            }if(t){
                            if(f.length){
                                l=n.html.search(h);c=n.html.substr(0,l+f.length)+"</em>"+n.html.substr(l+f.length);c=c.substr(0,l)+"<em>"+c.substr(l)
                                }else{
                                c=n.html
                                }o.html(c);this.result_activate(o);if(n.group_array_index!=null){
                                e("#"+this.results_data[n.group_array_index].dom_id).css("display","list-item")
                                }
                            }else{
                            if(this.result_highlight&&u===this.result_highlight.attr("id")){
                                this.result_clear_highlight()
                                }this.result_deactivate(o)
                            }
                        }
                    }
                }if(a<1&&f.length){
                return this.no_results(f)
                }else{
                return this.winnow_results_set_highlight()
                }
            };i.prototype.winnow_results_clear=function(){
            var t,n,r,i,s;this.search_field.val("");n=this.search_results.find("li");s=[];for(r=0,i=n.length;r<i;r++){
                t=n[r];t=e(t);if(t.hasClass("group-result")){
                    s.push(t.css("display","auto"))
                    }else if(!this.is_multiple||!t.hasClass("result-selected")){
                    s.push(this.result_activate(t))
                    }else{
                    s.push(void 0)
                    }
                }return s
            };i.prototype.winnow_results_set_highlight=function(){
            var e,t;if(!this.result_highlight){
                t=!this.is_multiple?this.search_results.find(".result-selected.active-result"):[];e=t.length?t.first():this.search_results.find(".active-result").first();if(e!=null)return this.result_do_highlight(e)
                    }
            };i.prototype.no_results=function(t){
            var n;n=e('<li class="no-results">'+this.results_none_found+' "<span></span>"</li>');n.find("span").first().html(t);return this.search_results.append(n)
            };i.prototype.no_results_clear=function(){
            return this.search_results.find(".no-results").remove()
            };i.prototype.keydown_arrow=function(){
            var t,n;if(!this.result_highlight){
                t=this.search_results.find("li.active-result").first();if(t)this.result_do_highlight(e(t))
                    }else if(this.results_showing){
                n=this.result_highlight.nextAll("li.active-result").first();if(n)this.result_do_highlight(n)
                    }if(!this.results_showing)return this.results_show()
                };i.prototype.keyup_arrow=function(){
            var e;if(!this.results_showing&&!this.is_multiple){
                return this.results_show()
                }else if(this.result_highlight){
                e=this.result_highlight.prevAll("li.active-result");if(e.length){
                    return this.result_do_highlight(e.first())
                    }else{
                    if(this.choices>0)this.results_hide();return this.result_clear_highlight()
                    }
                }
            };i.prototype.keydown_backstroke=function(){
            if(this.pending_backstroke){
                this.choice_destroy(this.pending_backstroke.find("a").first());return this.clear_backstroke()
                }else{
                this.pending_backstroke=this.search_container.siblings("li.search-choice").last();return this.pending_backstroke.addClass("search-choice-focus")
                }
            };i.prototype.clear_backstroke=function(){
            if(this.pending_backstroke){
                this.pending_backstroke.removeClass("search-choice-focus")
                }return this.pending_backstroke=null
            };i.prototype.keydown_checker=function(e){
            var t,n;t=(n=e.which)!=null?n:e.keyCode;this.search_field_scale();if(t!==8&&this.pending_backstroke)this.clear_backstroke();switch(t){
                case 8:this.backstroke_length=this.search_field.val().length;break;case 9:if(this.results_showing&&!this.is_multiple)this.result_select(e);this.mouse_on_container=false;break;case 13:e.preventDefault();break;case 38:e.preventDefault();this.keyup_arrow();break;case 40:this.keydown_arrow();break
                    }
            };i.prototype.search_field_scale=function(){
            var t,n,r,i,s,o,u,a,f;if(this.is_multiple){
                r=0;u=0;s="position:absolute; left: -1000px; top: -1000px; display:none;";o=["font-size","font-style","font-weight","font-family","line-height","text-transform","letter-spacing"];for(a=0,f=o.length;a<f;a++){
                    i=o[a];s+=i+":"+this.search_field.css(i)+";"
                    }n=e("<div />",{
                    style:s
                });n.text(this.search_field.val());e("body").append(n);u=n.width()+25;n.remove();if(u>this.f_width-10)u=this.f_width-10;this.search_field.css({
                    width:u+"px"
                    });t=this.container.height();return this.dropdown.css({
                    top:t+"px"
                    })
                }
            };i.prototype.generate_random_id=function(){
            var t;t="sel"+this.generate_random_char()+this.generate_random_char()+this.generate_random_char();while(e("#"+t).length>0){
                t+=this.generate_random_char()
                }return t
            };return i
        }(AbstractChosen);n=function(e){
        var t;return t=e.outerWidth()-e.width()
        };r.get_side_border_padding=n
    }).call(this)

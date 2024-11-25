console.log("Reply Module.....")
let replyService =(function(){
	
	// 댓글의 등록 처리
	function add(reply,callback,error){
		console.log("add reply.....");
	
		$.ajax({
			type : 'post',
			url  : '/api/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		})
	}
	// 댓글의 목록 처리
	function getList(param,callback,error){
		let dno = param.dno;
		let page = param.page || 1;
		$.getJSON("/api/replies/pages/"+dno+"/"+page+".json",
				  function(data){
				  	if(callback){
				  		callback(data);
				  	}
				  }).fail(function(xhr,status,err){
				  	if(error){
				  		error();
				  	}
				  });
	}
	
	// 댓글의 삭제 처리
	function remove(rno,callback,error){
		$.ajax({
			type : 'delete',
			url  : '/api/replies/' + rno,
			success : function(deleteResult,status,xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	// 댓글의 수정 처리
	function update(reply, callback, error){
		console.log("RNO" + reply.rno);
		
		$.ajax({
			type        : 'put',
			url         : '/api/replies/'+reply.rno,
			data        : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success		: function(result,status,xhr){
							if(callback){
								callback(result);
						    }
						  },
			error       : function(xhr, status, er){
						  	if(error){
						  		error(er);
						  	}
						  }
		});		
	}
	
	// 댓글의 조회 처리
	function get(rno, callback, error){
		$.get("/api/replies/" + rno + ".json" ,
			  function(result){
			  	if(callback){
			  		callback(result);
			  	}
			  }).fail(function(xhr, status, err){
			  	 	if(error){
			  	 		error();
			  	 	}
			  	 });
	}
	
	// 함수를 외부에 노출시킴
	return {add     : add,
			getList : getList,
			remove  : remove,
			update  : update,
			get     : get
			};
})();

const ctx = document.getElementById('myChart');
var opt = document.getElementById("years");
var optVal = opt.options[opt.selectedIndex].value;

var yselect = document.getElementById('yselect').value;

for(let i=0;i<opt.options.length;i++){
    if(opt.options[i].value==yselect){
        opt.options[i].selected=true;
    }
}

function yearChange() {
    var optVal = opt.options[opt.selectedIndex].value;
    location.href="main?year="+optVal;
}

var arr1=[1,2,3,4,5,6,7,8,9,10,11,12];
var arr2=new Array();
var month =  document.querySelectorAll('.month');
var sum =  document.querySelectorAll('.sum');
var totalval=0;
for(let j=0;j<month.length;j++){
    for(let i=1;i<=12;i++){
        if(i==month[j].value){
            arr2[i-1]=sum[j].value;
        }
    }
}
for(let i=0;i<sum.length;i++){
    totalval+=Number(sum[i].value);
}

for(let i=0;i<arr1.length;i++){
    if(typeof arr2[i]=="undefined"){
        arr2[i]=0;
    }
}
var total = document.getElementById("total");
total.innerHTML="<div id='total'>"+"총 "+totalval.toLocaleString('ko-KR')+"원"+"</div>";




new Chart(ctx, {
  type: 'line',
  data: {
    labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    datasets: [{
      label: optVal,
      data: [arr2[0], arr2[1], arr2[2], arr2[3], arr2[4], arr2[5],arr2[6],arr2[7],arr2[8],arr2[9],arr2[10],arr2[11]],
      borderWidth: 1,
      borderColor: 'black',
      backgroundColor:'#F7A072',
      fill:{
          target:'origin'
      }
    }]
  },
  options: {
    responsive:true,
    plugins: {
      title: {
          display: true,
          text: '순매출 수익',
          font:{
            size:30,
            family:'TTHakgyoansimMoheomgaB'
          }
      }
    },
    scales:{
        x:{
            display:true,
            title:{
                display:true,
                text:'매월',
                font:{
                    size:20,
                    family:'TTHakgyoansimMoheomgaB'
                }
            },
        },
        y:{
            display:true,
            title:{
                display:true,
                text:'매출수익',
                font:{
                    size:20,
                    family:'TTHakgyoansimMoheomgaB'
                }
            },
        }
    },
    transitions:{
        show:{
            animations:{
                x:{
                    from:0
                }
            }
        },
        hide:{
            animations:{
                x:{
                    to:0
                }
            }
        }
    }
  }
});
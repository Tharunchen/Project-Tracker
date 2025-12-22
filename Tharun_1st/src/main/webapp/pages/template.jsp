<%@ page contentType="text/html; charset=UTF-8" %>

<%
String username = (String) session.getAttribute("User");
String role = (String) session.getAttribute("Role");
if (username == null) username = "Guest";
if (role == null) role = "";
%>

<!DOCTYPE html>
<html>
<head>
<title>Project Tracker</title>

<link href="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>

<style>
body {
    margin: 0;
    background: #f5f6fb;
    font-family: Arial, sans-serif;
}

/* HEADER */
.header {
    height: 60px;
    background: white;
    display: flex;
    align-items: center;
    padding: 0 20px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
}

.header img {
    height: 40px;
}

.header h4 {
    flex: 1;
    text-align: center;
    margin: 0;
    color: #1e3a8a;
}

/* LAYOUT */
.main {
    display: flex;
}

/* SIDEBAR */
.sidebar {
    width: 240px;
    background: linear-gradient(180deg, #ede9fe, #f5f3ff);
    height: calc(100vh - 60px);
    display: flex;
    flex-direction: column;
    align-items: center;
    padding-top: 25px;
    box-shadow: inset -1px 0 0 rgba(0,0,0,0.05);
}


.profile-box {
    text-align: center;
    margin-box:25px;
}

.profile-box img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    border: 3px solid #7c3aed;
    margin-bottom: 10px;
}


.profile-name {
    font-weight: 600;
    font-size: 16px;
    margin-top: 6px;
    color: #4c1d95;
}

.profile-role {
    font-size: 13px;
    color: #6d28d9;
}
.content {
    flex: 1;
    padding: 20px;
}
.clock-card {
    margin-top: 25px;
    width: 220px;
    height: 220px;
    display: flex;
    align-items: center;
    justify-content: center;
}

#container {
    width: 220px;
    height: 220px;
}


</style>
</head>

<body>


<div class="header">
    <img src="${pageContext.request.contextPath}/images/industry.png">
    <h4>Project Tracker</h4>
    
     <a href="${pageContext.request.contextPath}/masterpages/Login.jsp">
                <img src="${pageContext.request.contextPath}/images/logout.png">
                </a>
                
</div>


<!-- BODY -->
<div class="main">

    <!-- LEFT PROFILE -->
    <div class="sidebar">
        <div class="profile-box">
            <img src="${pageContext.request.contextPath}/images/user.png">
            <div class="profile-name"><%= username %></div>
            <div class="profile-role"><%= role %></div>
        </div>
        <div class="clock-card">
            <div id="container" > </div>
        </div>
    </div>

    <!-- PAGE CONTENT -->
    <div class="content">
        <jsp:include page="${param.contentPage}" />
    </div>

</div>
<script>
const getNow = () => {
    const now = new Date();
    return {
        date: now,
        hours: now.getHours() + now.getMinutes() / 60,
        minutes: now.getMinutes() * 12 / 60 + now.getSeconds() * 12 / 3600,
        seconds: now.getSeconds() * 12 / 60
    };
};

let now = getNow();

// Create the chart
Highcharts.chart('container', {

    chart: {
        type: 'gauge',
        height: 250,
        backgroundColor: 'transparent'
    },

    credits: {
        enabled: false
    },

    title: {
        text: null
    },

    pane: {
        background: [{
            backgroundColor: '#ffffff',
            borderWidth: 0,
            innerRadius: '0%',
            outerRadius: '115%'
        }]
    },

    yAxis: {
        min: 0,
        max: 12,
        tickInterval: 1,
        lineWidth: 0,
        showFirstLabel: false,

        labels: {
            distance: -30,
            style: {
                fontSize: '18px',
                fontWeight: '600',
                color: '#111827'
            }
        },

        tickWidth: 4,
        tickLength: 14,
        tickPosition: 'inside',

        minorTickInterval: 'auto',
        minorTickWidth: 2,
        minorTickLength: 8,
        minorTickPosition: 'inside',

        title: {
            
            style: {
                color: '#95a5a6',
                fontSize: '10px'
            },
            y: 10
        }
    },

    tooltip: {
        format: '{series.chart.tooltipText}'
    },

    series: [{
        animation: false,
        dataLabels: {
            enabled: false
        },
        data: [{
            id: 'hour',
            y: now.hours,
            dial: {
                radius: '55%',
                baseWidth: 6,
                baseLength: '80%',
                rearLength: 0,
                backgroundColor: '#4f46e5'
            }
        }, {
            id: 'minute',
            y: now.minutes,
            dial: {
                baseWidth: 4,
                baseLength: '90%',
                backgroundColor: '#7c3aed'
            }
        }, {
            id: 'second',
            y: now.seconds,
            dial: {
                radius: '95%',
                baseWidth: 2,
                rearLength: '20%',
                backgroundColor: '#ef4444'
            }
        }]
    }]

}, function (chart) {

    setInterval(function () {

        now = getNow();

        if (chart.axes) {
            const hour = chart.get('hour'),
                  minute = chart.get('minute'),
                  second = chart.get('second');

            const h = now.date.getHours();
            const hour12 = h % 12 || 12;
            const minutes = String(now.date.getMinutes()).padStart(2, '0');
            const seconds = String(now.date.getSeconds()).padStart(2, '0');
            const ampm = h >= 12 ? 'PM' : 'AM';

            chart.tooltipText = hour12 + ':' + minutes + ':' + seconds + ' ' + ampm;



            hour.update(now.hours, true, false);
            minute.update(now.minutes, true, false);

            if (now.seconds === 0) {
                second.update(-0.2, true, false);
            }

            second.update(now.seconds, true, {
                easing: 'easeOutBounce'
            });
        }

    }, 1000);
});

/**
 * Bounce easing
 */
Math.easeOutBounce = function (pos) {
    if (pos < (1 / 2.75)) return 7.5625 * pos * pos;
    if (pos < (2 / 2.75)) return 7.5625 * (pos -= 1.5 / 2.75) * pos + 0.75;
    if (pos < (2.5 / 2.75)) return 7.5625 * (pos -= 2.25 / 2.75) * pos + 0.9375;
    return 7.5625 * (pos -= 2.625 / 2.75) * pos + 0.984375;
};
</script>
</body>
</html>

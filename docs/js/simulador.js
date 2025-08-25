const STORAGE_KEY='simulador-avance';
let plans={}, currentPlan='', states={};

const ANALISTA_OVERRIDES = {};

fetch('plans.json').then(r=>r.json()).then(data=>{
  plans=data;
  const sel=document.getElementById('plan');
  Object.entries(plans).forEach(([k,p])=>{
    const opt=document.createElement('option'); opt.value=k; opt.textContent=p.nombre||k; sel.appendChild(opt);
  });
  currentPlan = Object.keys(plans)[0]; sel.value=currentPlan;
  sel.addEventListener('change',()=>{ currentPlan=sel.value; loadStates(); render(); });
  document.getElementById('search').addEventListener('input',render);
  document.getElementById('onlyEnabled').addEventListener('change',render);
  loadStates(); render();
});

function loadStates(){
  const all=JSON.parse(localStorage.getItem(STORAGE_KEY)||'{}');
  states=all[currentPlan]||{};
}
function saveStates(){
  const all=JSON.parse(localStorage.getItem(STORAGE_KEY)||'{}');
  all[currentPlan]=states; localStorage.setItem(STORAGE_KEY,JSON.stringify(all));
}
function setState(code,val){
  const cur=states[code]||0;
  if(val>cur){
    if(val===1 && !canCursar(code)) return;
    if(val===2 && !canRendir(code)) return;
  }
  states[code]=val; saveStates(); render();
}
function getMateria(code){ return (plans[currentPlan].materias||[]).find(x=>x.codigo===code); }
function needs(list){
  return (list||[]).map(([slug,need])=>{
    const m = getMateria(slug);
    const st = states[slug]||0;
    const ok = !!m && st>=need;
    return {slug,need,exists:!!m,ok};
  });
}
function canCursar(code){ const m=getMateria(code); if(!m) return false; return needs(m.requisitos?.cursar).every(x=>x.ok); }
function canRendir(code){ const m=getMateria(code); if(!m) return false; return needs(m.requisitos?.rendir).every(x=>x.ok); }

const CUAT_LABEL = { '1':'1° Cuatrimestre', '2':'2° Cuatrimestre', 'anual':'Anual', 'extra':'Extracurricular', 'otro':'Otros' };
const CUAT_ORDER = ['1','2','anual','extra','otro'];
function cuatKey(c){
  const s = String(c).toLowerCase();
  if (s==='1' || s==='2') return s;
  if (s.includes('anual')) return 'anual';
  if (s.includes('extra')) return 'extra';
  return 'otro';
}

function render(){
  const q=(document.getElementById('search').value||'').toLowerCase();
  const only=document.getElementById('onlyEnabled').checked;
  const box=document.getElementById('materias'); box.innerHTML='';

  const grouped={};
  (plans[currentPlan].materias||[]).forEach(m=>{
    if(q && !(m.nombre.toLowerCase().includes(q))) return;
    if(only && !canCursar(m.codigo)) return;
    const key=cuatKey(m.cuatrimestre);
    if(!grouped[m.anio]) grouped[m.anio]={};
    if(!grouped[m.anio][key]) grouped[m.anio][key]=[];
    grouped[m.anio][key].push(m);
  });

  Object.keys(grouped).map(n=>+n).sort((a,b)=>a-b).forEach(anio=>{
    const y=document.createElement('section'); y.className='year';
    y.innerHTML=`<h2>${anio}° Año</h2>`;
    const grid=document.createElement('div'); grid.className='year-grid';

    CUAT_ORDER.forEach(key=>{
      const arr = grouped[anio][key]||[];
      if(!arr.length) return;
      const col=document.createElement('div'); col.className='cuat';
      const h3=document.createElement('h3'); h3.textContent=CUAT_LABEL[key]; col.appendChild(h3);

      arr.forEach(m=>{
        const s=states[m.codigo]||0;
        const reqC=needs(m.requisitos?.cursar), reqR=needs(m.requisitos?.rendir);
        const cls=['no','regular','aprobada'][s];
        const card=document.createElement('div'); card.className=`card ${cls}`;

        card.innerHTML = `
          <span class="badge">${['No','Regular','Aprobada'][s]}</span>
          <h4 class="title">${m.nombre}</h4>
          <div class="sub">${m.regimen} • ${m.carga_horaria}h</div>
          <div class="meta">
            <span class="chip">Año ${m.anio}</span>
            <span class="chip">${CUAT_LABEL[key]}</span>
          </div>

          ${reqC.length?`<div class="reqs"><strong style="opacity:.8">Cursar:</strong> ${
            reqC.map(r=>`<span class="req ${!r.exists?'unknown':(r.ok?'ok':'miss')}">
              ${r.ok?'✅':'🔒'} ${prettyName(r.slug)} ${r.need===2?'(aprobar)':'(regular)'}
            </span>`).join('')}
          </div>`:''}

          ${reqR.length?`<div class="reqs"><strong style="opacity:.8">Rendir:</strong> ${
            reqR.map(r=>`<span class="req ${!r.exists?'unknown':(r.ok?'ok':'miss')}">
              ${r.ok?'✅':'🔒'} ${prettyName(r.slug)} ${r.need===2?'(aprobar)':'(regular)'}
            </span>`).join('')}
          </div>`:''}

          <div class="state">
            <button class="btn off ${s===0?'active':''}">No</button>
            <button class="btn reg ${s===1?'active':''}">Reg</button>
            <button class="btn ok ${s===2?'active':''}">Apro</button>
          </div>
        `;

        const [b0,b1,b2]=card.querySelectorAll('.state .btn');
        b0.onclick=()=>setState(m.codigo,0);
        b1.onclick=()=>setState(m.codigo,1);
        b2.onclick=()=>setState(m.codigo,2);

        if(!canCursar(m.codigo)){ b1.disabled=true; b2.disabled=true; }
        else if(!canRendir(m.codigo)){ b2.disabled=true; }

        col.appendChild(card);
      });

      grid.appendChild(col);
    });

    y.appendChild(grid); box.appendChild(y);
  });

  updateStats();
}

function prettyName(slug){
  const m=getMateria(slug); return m?m.nombre:slug;
}

function updateStats(){
  const arr=plans[currentPlan].materias||[];
  const counts={0:0,1:0,2:0};
  arr.forEach(m=>{counts[states[m.codigo]||0]++;});

  document.getElementById('cAprob').textContent = counts[2];
  document.getElementById('cReg').textContent   = counts[1];
  document.getElementById('cNo').textContent    = counts[0];
  document.getElementById('cTot').textContent   = arr.length;

  const anaSet = (ANALISTA_OVERRIDES[currentPlan]||[]).length
    ? new Set(ANALISTA_OVERRIDES[currentPlan])
    : new Set(arr.filter(m=>Number(m.anio)<=3).map(m=>m.codigo));
  const anaTotal = anaSet.size;
  const anaAprob = Array.from(anaSet).filter(c=> (states[c]||0)===2).length;
  const anaPct = anaTotal ? Math.round(100*anaAprob/anaTotal) : 0;

  document.getElementById('mAnalista').style.width = anaPct + '%';
  document.getElementById('pAna').textContent      = anaPct + '%';

  const licTotal = arr.length;
  const licAprob = counts[2];
  const licPct   = licTotal ? Math.round(100*licAprob/licTotal) : 0;

  document.getElementById('mLic').style.width = licPct + '%';
  document.getElementById('pLic').textContent = licPct + '%';
}

const BADGE_STYLE = 'for-the-badge';

function computeLicPct(){
  const arr=plans[currentPlan].materias||[];
  const total=arr.length;
  const aprob=arr.filter(m=>(states[m.codigo]||0)===2).length;
  return total? Math.round(100*aprob/total) : 0;
}
function highestFullYearApproved(){
  const arr=(plans[currentPlan].materias||[]).slice().sort((a,b)=>a.anio-b.anio);
  let max=0;
  for(let y=1;y<=5;y++){
    const all = arr.filter(m=>Number(m.anio)===y);
    if(!all.length) break;
    if(all.every(m => (states[m.codigo]||0)===2)) max=y; else break;
  }
  return max;
}
function currentShareHash(){
  const payload={ plan: currentPlan, states };
  const json=JSON.stringify(payload);
  return btoa(unescape(encodeURIComponent(json)));
}
function shareUrl(){
  const base = `${location.origin}${location.pathname.replace(/\/[^\/]*$/,'/')}`;
  return `${base}estado.html#${currentShareHash()}`;
}
function copyToClipboard(text){
  if (navigator.clipboard?.writeText) {
    navigator.clipboard.writeText(text).then(()=>alert('Copiado ✅'));
  } else {
    const ta=document.createElement('textarea'); ta.value=text;
    document.body.appendChild(ta); ta.select(); document.execCommand('copy');
    document.body.removeChild(ta); alert('Copiado ✅');
  }
}
function colorByPct(p){
  if(p>=90) return '16a34a';
  if(p>=70) return '22c55e';
  if(p>=50) return 'f59e0b';
  if(p>=30) return 'f97316';
  return '64748b';
}
function makeYearBadgeMarkdown(){
  const year = highestFullYearApproved();
  const label = encodeURIComponent('🎓 LSI');
  const msg   = encodeURIComponent( year===0 ? 'Ingresante' : `${year}º año` );
  const color = '16a34a';
  const url = `https://img.shields.io/badge/${label}-${msg}-${color}?style=${BADGE_STYLE}`;
  return `[![LSI · ${year===0?'Ingresante':year+'º año'}](${url})](${shareUrl()})`;
}
function makePctBadgeMarkdown(){
  const pct = computeLicPct();
  const label = encodeURIComponent('🎓 Avance LSI');
  const msg   = encodeURIComponent(`${pct}%`);
  const color = colorByPct(pct);
  const url = `https://img.shields.io/badge/${label}-${msg}-${color}?style=${BADGE_STYLE}`;
  return `[![Avance LSI ${pct}%](${url})](${shareUrl()})`;
}
document.getElementById('share').onclick=()=>copyToClipboard(shareUrl());
document.getElementById('badgeYear').onclick=()=>copyToClipboard(makeYearBadgeMarkdown());
document.getElementById('badgePct').onclick=()=>copyToClipboard(makePctBadgeMarkdown());

document.getElementById('save').onclick=()=>{
  saveStates(); const btn=document.getElementById('save'); const t=btn.textContent;
  btn.textContent='Guardado ✓'; setTimeout(()=>btn.textContent=t,900);
};
document.getElementById('reset').onclick=()=>{
  if(confirm('¿Reiniciar estados del plan actual?')){ states={}; saveStates(); render(); }
};
document.getElementById('export').onclick=()=>{
  const data=localStorage.getItem(STORAGE_KEY)||'{}';
  const blob=new Blob([data],{type:'application/json'});
  const a=document.createElement('a'); a.href=URL.createObjectURL(blob); a.download='simulador.json'; a.click();
};
document.getElementById('import').onclick=()=>document.getElementById('fileInput').click();
document.getElementById('fileInput').addEventListener('change',e=>{
  const file=e.target.files[0]; if(!file) return;
  const reader=new FileReader();
  reader.onload=ev=>{ try{ localStorage.setItem(STORAGE_KEY,ev.target.result); loadStates(); render(); }catch{ alert('JSON inválido'); } };
  reader.readAsText(file);
});

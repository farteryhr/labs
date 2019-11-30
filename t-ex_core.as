function init(){
    for (var _loc2 = 0; _loc2 < 10; ++_loc2)
    {
        for (var _loc1 = -5; _loc1 < 22; ++_loc1)
        {
            ablox[ofx + _loc2][ofy + _loc1] = -1;
        } // end of for
    } // end of for
    nscore = 0;
    nline = 0;
    npoint = 0;
    maxx = 0;
    nbs = 0;
    holdblx = 0;
    makenext();
    nowact = 1;
    delayc = 120;
    nlevel = 0;
    changemovedl(nlevel);
    kpml = 0;
    kcml = 0;
    kpmr = 0;
    kcmr = 0;
    kpmd = 0;
    kcmd = 0;
    kprl = 0;
    kcrl = 0;
    kprr = 0;
    kcrr = 0;
    kpro = 0;
    kcro = 0;
    kpfd = 0;
    kcfd = 0;
    kphd = 0;
    kchd = 0;
    cheat = 0;
    changebg(nlevel);
    histblx = [6, 7, 6, 7];
    died = 0;
    stopbgm();
    needupdatebgm = 1;
    fldbg.gotoAndStop(int(nlevel / 10 + 1));
} // End of the function
function readkey()
{
    kpml = Number(Key.isDown(kml));
    kpmr = Number(Key.isDown(kmr));
    kpmd = Number(Key.isDown(kmd));
    kprl = Number(Key.isDown(krl));
    kprr = Number(Key.isDown(krr));
    kpro = Number(Key.isDown(kro));
    kpfd = Number(Key.isDown(kfd));
    kphd = Number(Key.isDown(khd));
    kpch = Number(Key.isDown(kch));
    kpps = Number(Key.isDown(kps));
} // End of the function
function gamef(frames)
{
    touchsnded = 0;
    for (var _loc6 = 0; _loc6 < frames; ++_loc6)
    {
        var _loc10 = 0;
        var _loc12 = 0;
        var _loc7 = 0;
        var _loc14 = 0;
        var _loc13 = 0;
        var _loc11 = 0;
        var _loc8 = 0;
        var _loc3 = 0;
        var _loc15 = 0;
        var _loc4 = 0;
        var _loc9 = 0;
        var _loc5;
        readkey();
        if (kpch == 1 && kcch == 0)
        {
            kcch = 1;
            if(cheat==1)
            {
                npoint = npoint + 100;
            }
            else
            {
                cheat = 1;
            }
        }
        else if (kpch == 0)
        {
            kcch = 0;
        } // end else if
        if (kpps == 1 && kcps == 0)
        {
            kcps = 1;
            ped = 1 - ped;
        }
        else if (kpps == 0)
        {
            kcps = 0;
        } // end else if
        if (ped == 0)
        {
            _loc5 = 0;
            switch (nowact)
            {
                case 1:
                {
                    _loc5 = 1;
                    --delayc;
                    if (delayc <= 0)
                    {
                        nbs = nextblx[0];
                        if (npoint != 99)
                        {
                            ++npoint;
                        } // end if
                        makenew();
                        makenext();
                        startbgm(nlevel);
                        break;
                    } // end if
                    holdb(0);
                    if (kpml == 1 && (kcml == 0 || kpmr == 0))
                    {
                        kcml = movedl;
                        kcmr = movedl + 1;
                    }
                    else if (kpmr == 1 && (kcmr == 0 || kpml == 0))
                    {
                        kcmr = movedl;
                        kcml = movedl + 1;
                    } // end else if
                    if (kpfd == 0 && kcfd == 1)
                    {
                        kcfd = 0;
                    } // end if
                    kpr2kcr();
                    break;
                } 
                case 2:
                {
                    if (kpmd == 1 && kcmd == 0)
                    {
                        if (nlevel < 5)
                        {
                            delayc = 1;
                        }
                        else
                        {
                            fallb(20, 0);
                        } // end if
                    } // end else if
                    if (kpmd == 0)
                    {
                        kcmd = 0;
                    } // end if
                    if (kpfd == 0)
                    {
                        kcfd = 0;
                    } // end if
                    if (kpfd == 1 && kcfd == 0)
                    {
                        nby = fallb(20, 1);
                        kcfd = 2;
                        drop();
                        break;
                    } // end if
                    holdb(1);
                    if (nowact != 2)
                    {
                        break;
                    } // end if
                    _loc4 = moveb();
                    kpr2kcr();
                    rotateb(_loc4, 0);
                    --delayc;
                    if (delayc <= 0)
                    {
                        fallb(lvgdist[nlevel], 0);
                        if (nowact == 2)
                        {
                            delayc = lvgdelay[nlevel];
                        } // end if
                        break;
                    } // end if
                    break;
                } 
                case 3:
                {
                    if (kpfd == 0)
                    {
                        kcfd = 0;
                    } // end if
                    if (kpfd == 1 && kcfd == 0)
                    {
                        delayc = 1;
                        kcfd = 1;
                        drop();
                        break;
                    } // end if
                    if (kpmd == 0)
                    {
                        kcmd = 0;
                    } // end if
                    holdb(1);
                    if (nowact != 3)
                    {
                        break;
                    } // end if
                    _loc4 = moveb();
                    kpr2kcr();
                    rotateb(_loc4, 0);
                    if (isok(nbs, nbr, nbx, nby + 1))
                    {
                        _loc4 = maxx;
                        if (lvgdelay[nlevel] != 0)
                        {
                            if (fallb(lvgdist[nlevel], 0) > _loc4)
                            {
                                nowact = 2;
                                delayc = lvgdelay[nlevel];
                            } // end if
                        }
                        else if (fallb(20, 0) > _loc4)
                        {
                            delayc = lvldelay[nlevel];
                        } // end else if
                    }
                    else
                    {
                        delayc = delayc - 1;
                        if (delayc <= 0)
                        {
                            drop();
                            break;
                        } // end if
                    } // end else if
                    break;
                } 
                case 4:
                {
                    _loc5 = 1;
                    if (died == 1)
                    {
                        if (delayc % 10 == 0)
                        {
                            for (var _loc2 = 0; _loc2 < 10; ++_loc2)
                            {
                                sblk[_loc2][21 - int(delayc / 10)] = colors[tstyle][ablox[_loc2 + ofx][21 - int(delayc / 10) + ofy]] + 16 + 1;
                                sblkt[_loc2][21 - int(delayc / 10)] = 5;
                                ablox[_loc2 + ofx][21 - int(delayc / 10) + ofy] = -1;
                            } // end of for
                        } // end if
                        ++delayc;
                        if (delayc == 219)
                        {
                            die();
                        } // end if
                    }
                    else
                    {
                        if (delayc % 8 == 0)
                        {
                            for (var _loc2 = 0; _loc2 < 10; ++_loc2)
                            {
                                if (ablox[_loc2 + ofx][21 - int(delayc / 8) + ofy] != -1)
                                {
                                    sblk[_loc2][21 - int(delayc / 8)] = 26;
                                    sblkt[_loc2][21 - int(delayc / 8)] = 4;
                                } // end if
                                ablox[_loc2 + ofx][21 - int(delayc / 8) + ofy] = -1;
                            } // end of for
                        } // end if
                        ++delayc;
                        if (delayc == 176)
                        {
                            nowact = 1;
                            delayc = 60;
                            fldbg.gotoAndStop(int(nlevel / 10 + 1));
                        } // end if
                    } // end else if
                    break;
                } 
                case 5:
                {
                    _loc5 = 1;
                    if (kpfd == 0 && kcfd == 1)
                    {
                        kcfd = 0;
                    } // end if
                    delayc = delayc - 1;
                    if (delayc <= 0)
                    {
                        fallfield();
                        nowact = 1;
                        delayc = newdelay[nlevel];
                    } // end if
                    holdb(0);
                    if (kpml == 1 && (kcml == 0 || kpmr == 0))
                    {
                        kcml = movedl;
                        kcmr = movedl + 1;
                    }
                    else if (kpmr == 1 && (kcmr == 0 || kpml == 0))
                    {
                        kcmr = movedl;
                        kcml = movedl + 1;
                    } // end else if
                    kpr2kcr();
                    break;
                } 
            } // End of switch
        } // end if
        if (Math.sqrt(Math.pow(bgtx - bgnx, 2) + Math.pow(bgty - bgny, 2)) > 1)
        {
            bgny = bgny + 1.000000E-001 * (bgty - bgny) / Math.sqrt(Math.pow(bgtx - bgnx, 2) + Math.pow(bgty - bgny, 2));
            bgnx = bgnx + 1.000000E-001 * (bgtx - bgnx) / Math.sqrt(Math.pow(bgtx - bgnx, 2) + Math.pow(bgty - bgny, 2));
        }
        else
        {
            bgty = -bgmy / 21 * (20 - nlevel) - Math.random() * bgmy / 21;
            bgtx = -Math.random() * bgmx;
        } // end else if
        for (var _loc3 = 0; _loc3 < 10; ++_loc3)
        {
            for (var _loc1 = 0; _loc1 < 22; ++_loc1)
            {
                if (sblkt[_loc3][_loc1] >= 0)
                {
                    sblkt[_loc3][_loc1] = sblkt[_loc3][_loc1] - 1;
                } // end if
            } // end of for
        } // end of for
    } // end of for
    rend(_loc5);
} // End of the function
function drop()
{
    var _loc3 = 0;
    var _loc4 = 0;
    var _loc2 = 0;
    var _loc1 = 0;
    for (var _loc2 = 0; _loc2 < 4; ++_loc2)
    {
        for (var _loc1 = 0; _loc1 < 4; ++_loc1)
        {
            if (kblox[nbs][nbr * 16 + _loc1 * 4 + _loc2] != -1)
            {
                ablox[nbx + _loc2 + ofx + psofx[tstyle][nbs][nbr]][nby + _loc1 + ofy + psofy[tstyle][nbs][nbr]] = nlevel >= 15 ? (0) : (nbs);
            } // end if
        } // end of for
    } // end of for
    playsfx(sfxlock);
    nscore = nscore + Math.pow(2, (20 - nby) / 20) * Math.pow(2, nlevel / 5) * 25;
    justhold = 0;
    maxx = -1;
    paintflash(nbs, nbr, nbx, nby);
    _loc3 = killline();
    dontdispnow = 1;
    if (_loc3 != 0)
    {
        delayc = linedelay[nlevel];
        nowact = 5;
        playsfx(sfxlc);
    }
    else
    {
        delayc = newdelay[nlevel];
        nowact = 1;
    } // end else if
    if (npoint >= 100)
    {
        nlevel += int(npoint / 100);
        npoint %= 100;
        changemovedl(nlevel);
        changebg(nlevel);
        playsfx(sfxlvlup);
        if (nlevel == 10 || nlevel == 20)
        {
            nowact = 4;
            delayc = 0;
        } // end if
        needupdatebgm = 1;
    } // end if
    if (died == 0)
    {
        procceedbgm();
    } // end if
} // End of the function
function paintsplash(bs, br, bx, by)
{
    if (nlevel < 10)
    {
        for (var _loc2 = 0; _loc2 < 4; ++_loc2)
        {
            for (var _loc1 = 0; _loc1 < 4; ++_loc1)
            {
                if (kblox[bs][br * 16 + _loc1 * 4 + _loc2] != -1)
                {
                    sblk[bx + _loc2 + psofx[tstyle][nbs][nbr]][by + _loc1 + psofy[tstyle][nbs][nbr]] = nlevel >= 15 ? (17) : (colors[tstyle][nbs] + 16 + 1);
                    sblkt[bx + _loc2 + psofx[tstyle][nbs][nbr]][by + _loc1 + psofy[tstyle][nbs][nbr]] = 2;
                } // end if
            } // end of for
        } // end of for
    } // end if
} // End of the function
function paintflash(bs, br, bx, by)
{
    for (var _loc2 = 0; _loc2 < 4; ++_loc2)
    {
        for (var _loc1 = 0; _loc1 < 4; ++_loc1)
        {
            if (kblox[bs][br * 16 + _loc1 * 4 + _loc2] != -1)
            {
                sblk[bx + _loc2 + psofx[tstyle][nbs][nbr]][by + _loc1 + psofy[tstyle][nbs][nbr]] = 26;
                sblkt[bx + _loc2 + + psofx[tstyle][nbs][nbr]][by + _loc1 + psofy[tstyle][nbs][nbr]] = 4;
            } // end if
        } // end of for
    } // end of for
} // End of the function
function rend(nocurr)
{
    time = new Date();
    sttime = time.getTime();
    for (var _loc1 = 0; _loc1 < 10; ++_loc1)
    {
        for (var _loc2 = 0; _loc2 < 22; ++_loc2)
        {
            if (nlevel == 20 && nowact != 4)
            {
                fblk[_loc1][_loc2] = 25;
                continue;
            } // end if
            if (ablox[_loc1 + ofx][_loc2 + ofy] == -1)
            {
                fblk[_loc1][_loc2] = 25;
                continue;
            } // end if
            fblk[_loc1][_loc2] = 8 + colors[tstyle][ablox[_loc1 + ofx][_loc2 + ofy]] + 1;
        } // end of for
    } // end of for
    for (var _loc1 = 0; _loc1 < 10; ++_loc1)
    {
        for (var _loc2 = 0; _loc2 < 22; ++_loc2)
        {
            if (sblkt[_loc1][_loc2] >= 0)
            {
                fblk[_loc1][_loc2] = sblk[_loc1][_loc2];
            } // end if
        } // end of for
    } // end of for
    if (nocurr == 0)
    {
        tmp = fallb(20, 1);
        for (var _loc1 = 0; _loc1 < 4; ++_loc1)
        {
            for (var _loc2 = 0; _loc2 < 4; ++_loc2)
            {
                if (kblox[nbs][nbr * 16 + _loc1 + _loc2 * 4] != -1)
                {
                    if (nowact != 4 && nowact != 5 && nlevel < 5)
                    {
                        fblk[nbx + _loc1 + psofx[tstyle][nbs][nbr]][tmp + _loc2 + psofy[tstyle][nbs][nbr]] = 16 + colors[tstyle][nbs] + 1;
                    } // end if
                    fblk[nbx + _loc1 + psofx[tstyle][nbs][nbr]][nby + _loc2 + psofy[tstyle][nbs][nbr]] = nlevel >= 15 ? (1) : (colors[tstyle][nbs] + 1);
                } // end if
            } // end of for
        } // end of for
    } // end if
    if (ped == 0)
    {
        for (var _loc1 = 0; _loc1 < 10; ++_loc1)
        {
            for (var _loc2 = 0; _loc2 < 22; ++_loc2)
            {
                mblk[_loc1][_loc2].gotoAndStop(fblk[_loc1][_loc2]);
            } // end of for
        } // end of for
    }
    else
    {
        for (var _loc1 = 0; _loc1 < 10; ++_loc1)
        {
            for (var _loc2 = 2; _loc2 < 22; ++_loc2)
            {
                mblk[_loc1][_loc2].gotoAndStop(25);
                pnum = (pnum + 1) % 201;
            } // end of for
        } // end of for
    } // end else if
    for (var _loc1 = 0; _loc1 < 16; ++_loc1)
    {
        if (int(_loc1 / 4) - inity[tstyle][holdblx] >= 0 && int(_loc1 / 4) - inity[tstyle][holdblx] <= 3)
        {
            if (kblox[holdblx][initr[tstyle][holdblx] * 16 - inity[tstyle][holdblx] * 4 + _loc1] == -1)
            {
                mhld[_loc1].gotoAndStop(25);
            }
            else
            {
                mhld[_loc1].gotoAndStop(justhold == 1 ? (9) : (nlevel >= 15 ? (1) : (colors[tstyle][holdblx] + 1)));
            } // end else if
            continue;
        } // end if
        mhld[_loc1].gotoAndStop(25);
    } // end of for
    for (var _loc1 = 0; _loc1 < 3; ++_loc1)
    {
        for (var _loc2 = 0; _loc2 < 16; ++_loc2)
        {
            if (int(_loc2 / 4) - inity[tstyle][nextblx[_loc1]] >= 0 && int(_loc2 / 4) - inity[tstyle][nextblx[_loc1]] <= 3)
            {
                if (kblox[nextblx[_loc1]][initr[tstyle][nextblx[_loc1]] * 16 - inity[tstyle][nextblx[_loc1]] * 4 + _loc2] == -1)
                {
                    mnxt[_loc1][_loc2].gotoAndStop(25);
                }
                else
                {
                    mnxt[_loc1][_loc2].gotoAndStop(nlevel >= 15 ? (1) : (colors[tstyle][nextblx[_loc1]] + 1));
                } // end else if
                continue;
            } // end if
            mnxt[_loc1][_loc2].gotoAndStop(25);
        } // end of for
    } // end of for
    bggamemc._x = bgnx;
    bggamemc._y = bgny;
    if (nowact == 3)
    {
        tls.gotoAndStop(int(delayc / lvldelay[nlevel] * 20) + 1);
    }
    else if (nowact == 4)
    {
        tls.gotoAndStop(1);
    }
    else if (nowact == 1)
    {
        tls.stop();
    }
    else
    {
        tls.gotoAndStop(21);
    } // end else if
    time = new Date();
    frmtime = time.getTime() - sttime;
    txt.text =
        "+R-Level: " + levelstr(nlevel) + "-" + npoint + 
//        "\n\n坢L?Lines: " + nline +
        "\n\nb閪-Score: " + (cheat == 1 ? ("Hahaha...") : (int(nscore))) +
//        "\n\nT-EX.tk - v20111124\n\nPress [P] to" + (ped == 0 ? ("Pause") : ("Continue")) +
        "\n\nGfx: " + curffps + "/60fps\nRender Time: " + frmtime + "ms" +
//        "\n\nLet\'s Play TO-P\nhttp://to-p.tk/" +
//        "\n\nIf you like this game,\nplease share it~" + 
        "\n\nBest today: " + highest + (submitted == 1 ? ("-OK") : (""));
} // End of the function
function vbstring(times)
{
    var _loc2 = "";
    for (var _loc1 = 0; _loc1 < times; ++_loc1)
    {
        _loc2 = _loc2 + "|";
    } // end of for
    return (_loc2);
} // End of the function
function changemovedl()
{
    kcml = 0;
    kcmr = 0;
    movedl = getmovedl();
} // End of the function
function getmovedl()
{
    return (movedelay[nlevel]);
} // End of the function
function resetlockdl(snd)
{
    delayc = lvldelay[nlevel];
    if (snd == 1 && touchsnded == 0)
    {
        playsfx(sfxtouch);
        touchsnded = 1;
    } // end if
    return (0);
} // End of the function
function levelstr(level)
{
    if (level < 10)
    {
        return ("H" + level);
    }
    else if (level < 20)
    {
        return ("M" + (level - 10));
    }
    else
    {
        return ("WTF");
    } // end else if
} // End of the function
function makenext()
{
    if (nextblx[0] == 0)
    {
        nextblx[0] = makenextin();
        nextblx[1] = makenextin();
        nextblx[2] = makenextin();
    }
    else
    {
        nextblx[0] = nextblx[1];
        nextblx[1] = nextblx[2];
        nextblx[2] = makenextin();
    } // end else if
} // End of the function
function makenew()
{
    nbr = initr[tstyle][nbs];
    nbx = 3;
    nby = inity[tstyle][nbs];
    maxx = 0;
    tmp = maxup;
    maxup = 0;
    rotateb(0, 0);
    maxup = tmp;
    movcnt = 0;
    if (nbr != initr[tstyle][nbs])
    {
        playsfx(sfxirs);
    } // end if
    nowact = 2;
    if (!isok(nbs, nbr, nbx, nby))
    {
        drop();
        delayc = 0;
        nowact = 4;
        died = 1;
        stopbgm();
        return;
    } // end if
    if (lvgdelay[nlevel] == 0)
    {
        fallb(20, 0);
    }
    else
    {
        delayc = lvgdelay[nlevel];
    } // end else if
    dontdispnow = 0;
} // End of the function
function makenextin()
{
    var _loc2 = 0;
    var _loc3 = 0;
    for (var _loc4 = 0; _loc4 < 4; ++_loc4)
    {
        _loc2 = random(7) + 1;
        _loc3 = 0;
        for (var _loc1 = 0; _loc1 < 6; ++_loc1)
        {
            if (histblx[_loc1] == _loc2)
            {
                _loc3 = 1;
                break;
            } // end if
        } // end of for
        if (_loc3 == 0)
        {
            histblx[histptr] = _loc2;
            ++histptr;
            histptr = histptr >= 4 ? (histptr - 4) : (histptr);
            return (_loc2);
        } // end if
    } // end of for
    histblx[histptr] = _loc2;
    ++histptr;
    histptr = histptr >= 4 ? (histptr - 4) : (histptr);
    return (_loc2);
} // End of the function
function kpr2kcr()
{
    if (kprl == 1 && kcrl == 0)
    {
        kcrl = 1;
        kcrset(0);
        kcrset(1);
    } // end if
    if (kprr == 1 && kcrr == 0)
    {
        kcrr = 1;
        kcrset(0);
        kcrset(-1);
    } // end if
    if (kpro == 1 && kcro == 0)
    {
        kcro = 1;
        kcrset(1);
        kcrset(-1);
    } // end if
    if (kprl == 0)
    {
        kcrl = 0;
    } // end if
    if (kprr == 0)
    {
        kcrr = 0;
    } // end if
    if (kpro == 0)
    {
        kcro = 0;
    } // end if
} // End of the function
function kcrset(a)
{
    if (a == -1)
    {
        if (kcrl == 1)
        {
            kcrl = 2;
        } // end if
    }
    else if (a == 1)
    {
        if (kcrr == 1)
        {
            kcrr = 2;
        } // end if
    }
    else if (a == 0)
    {
        if (kcro == 1)
        {
            kcro = 2;
        } // end else if
    } // end else if
} // End of the function
function isok(blox, rmode, tx, ty)
{
    for (var _loc2 = 0; _loc2 < 4; ++_loc2)
    {
        for (var _loc1 = 0; _loc1 < 4; ++_loc1)
        {
            if (kblox[blox][rmode * 16 + _loc1 * 4 + _loc2] != -1)
            {
                if (ablox
                    [tx + _loc2 + ofx + psofx[tstyle][blox][rmode]]
                    [ty + _loc1 + ofy + psofy[tstyle][blox][rmode]]
                    != -1)
                {
                    return (false);
                } // end if
            } // end if
        } // end of for
    } // end of for
    return (true);
} // End of the function
function isoknp(dmode, dx, dy)
{
    if (maxup < -dy || nby + dy < maxx - maxup)
    {
        return (false);
    } // end if
    if (isok(nbs, rin4(nbr, dmode), nbx + dx, nby + dy))
    {
        return (true);
    }
    else
    {
        return (false);
    } // end else if
} // End of the function
function letnp(dmode, dx, dy, isro)
{
    nbr = rin4(nbr, dmode);
    nbx = nbx + dx;
    nby = nby + dy;
    if (isro == 1)
    {
        kcro = 2;
    } // end if
    else
    {
        if (dmode == 1)
        {
            kcrr = 2;
        } // end if
        if (dmode == -1)
        {
            kcrl = 2;
        } // end if
    }
    if (nowact == 3)
    {
        if (movcnt < movlmt)
        {
            resetlockdl(1);
            ++movcnt;
        } // end if
    } // end if
} // End of the function
function fallfield()
{
    var _loc2 = 0;
    var _loc1 = 0;
    var _loc4 = 0;
    var _loc3 = 0;
    var _loc5 = new Array(30);
    for (var _loc1 = -ofy; _loc1 < 22; ++_loc1)
    {
        _loc5[_loc1 + ofy] = 0;
    } // end of for
    for (var _loc2 = 0; _loc2 < kline; ++_loc2)
    {
        _loc5[klines[_loc2] + ofy] = 1;
    } // end of for
    for (var _loc1 = 21; _loc1 >= 0; --_loc1)
    {
        _loc4 = 0;
        for (var _loc2 = 0; _loc2 < kline; ++_loc2)
        {
            if (klines[_loc2] >= _loc1)
            {
                ++_loc4;
            } // end if
        } // end of for
        _loc3 = _loc1;
        while (_loc4 > 0)
        {
            --_loc3;
            if (_loc5[_loc3 + ofy] == 0)
            {
                --_loc4;
            } // end if
        } // end while
        if (_loc3 < _loc1)
        {
            for (var _loc2 = 0; _loc2 < 10; ++_loc2)
            {
                ablox[_loc2 + ofx][_loc1 + ofy] = ablox[_loc2 + ofx][_loc3 + ofy];
            } // end of for
        } // end if
    } // end of for
    playsfx(sfxfall);
    if (cheat == 1 && kline > 1 && nlevel != 20)
    {
        /*
        if (nlevel < 10)
        {
            --kline;
        }
        else if (nlevel >= 15)
        {
            kline = Math.pow(2, kline - 1);
        } // end else if
        */
        kline = [0,0,1,2,4][kline];
        for (var _loc2 = 0; _loc2 < 10; ++_loc2)
        {
            for (var _loc1 = 0; _loc1 < 22 - kline; ++_loc1)
            {
                ablox[_loc2 + ofx][_loc1 + ofy] = ablox[_loc2 + ofx][_loc1 + kline + ofy];
            } // end of for
            for (var _loc1 = 22 - kline; _loc1 < 22; ++_loc1)
            {
                ablox[_loc2 + ofx][_loc1 + ofy] = 0;
            } // end of for
        } // end of for
        _loc3 = random(10);
        for (var _loc1 = 22 - kline; _loc1 < 22; ++_loc1)
        {
            ablox[_loc3 + ofx][_loc1 + ofy] = -1;
        } // end of for
    } // end if
} // End of the function
function killline()
{
    var _loc1 = 0;
    var _loc2 = 0;
    var _loc3 = 0;
    var _loc6 = 0;
    var _loc4 = 0;
    var _loc5 = 0;
    var _loc7 = new Array(22);
    kline = 0;
    for (var _loc2 = 0; _loc2 < 22; ++_loc2)
    {
        _loc3 = 0;
        for (var _loc1 = 0; _loc1 < 10; ++_loc1)
        {
            _loc3 = _loc3 + (ablox[_loc1 + ofx][_loc2 + ofy] == -1 ? (0) : (1));
        } // end of for
        if (_loc3 == 10)
        {
            for (var _loc1 = 0; _loc1 < 10; ++_loc1)
            {
                if (ablox[_loc1 + ofx][_loc2 + ofx - 1] != -1)
                {
                    int(ablox[_loc1 + ofx][_loc2 + ofy - 1] / 2) * 2;
                } // end if
                if (ablox[_loc1 + ofx][_loc2 + ofx + 1] != -1)
                {
                    int(ablox[_loc1 + ofx][_loc2 + ofy + 1] / 4) * 4 + ablox[_loc1 + ofx][_loc2 + ofy + 1] % 2;
                } // end if
                ablox[_loc1 + ofx][_loc2 + ofy] = -1;
                sblk[_loc1][_loc2] = 26;
                sblkt[_loc1][_loc2] = 2;
            } // end of for
            klines[kline] = _loc2;
            ++kline;
            _loc4 = _loc4 + 1;
            _loc5 = _loc5 + Math.pow(2, nlevel / 5) * 150;
            continue;
        } // end if
        klines[_loc2] = 0;
    } // end of for
    npoint = nlevel == 20 ? (0) : (npoint + _loc4);
    nscore = nscore + _loc4 * _loc5;
    nline = nline + _loc4;
    return (_loc4);
} // End of the function
function rin4(a, b)
{
    if (a + b >= 4)
    {
        return (a + b - 4);
    } // end if
    if (a + b < 0)
    {
        return (a + b + 4);
    } // end if
    return (a + b);
} // End of the function
function wktry(dmmode, dire, ttime)
{
    if (isoknp(dire,
               wktbl[dmmode][ttime][0] * dire,
               wktbl[dmmode][ttime][1]
    ))
    {
        return (true);
    } // end if
} // End of the function
function wkapl(dmmode, dire, ttime, isro)
{
    //trace("dmmode="+dmmode+" ttime="+ttime);
    letnp(dire,
          wktbl[dmmode][ttime][0] * dire,
          wktbl[dmmode][ttime][1],
          isro
    );
} // End of the function
function rotateb(moving, dire)
{
    var isro = 0;
    if (kcrr != 1 && kcrl != 1 && kcro != 1)
    {
        return;
    } // end if
    
        if (kcrl == 1)
        {
            dire = -1;
        } // end if
        else if (kcrr == 1)
        {
            dire = 1;
        } // end if
        else if (kcro == 1)
        {
            isro = 1;
            if (nowact == 1)
            {
                letnp(2, 0, 0, isro);
                return;
            }
            else if (kprl != kprr)
            {
                if (kprl == 1)
                {
                    dire = -1;
                }
                else
                {
                    dire = 1;
                } // end if
            } // end else if
            else
            {
                dire = -1;
            }
        } // end else if
    
    var dmmode = 0;
    if (moving == 0)
    {
        dmmode = 0;
    }
    else if (dire == moving)
    {
        dmmode = 1;
    }
    else if(dire = -moving)
    {
        dmmode = 2;
    }
    for (var _loc2 = 0; _loc2 < wktblc[dmmode]; ++_loc2)
    {
        if (wktry(dmmode, dire, _loc2))
        {
            wkapl(dmmode, dire, _loc2, isro);
            break;
        } // end if
    } // end of for
} // End of the function
function moveb()
{
    var _loc1 = 0;
    if (kpml == 0)
    {
        kcml = 0;
    }
    else if (kpml == 1)
    {
        if (kcml == 0)
        {
            if (kpmr == 1)
            {
                kcmr = movedl + 1;
                kcml = 1;
            }
            else
            {
                kcml = 1;
            } // end else if
        }
        else if (kcml == movedl + 1 && kpmr == 0)
        {
            kcml = movedl;
        } // end else if
        if (kcml == 1 || kcml == movedl)
        {
            if (isoknp(0, -1, 0))
            {
                --nbx;
                _loc1 = 1;
                if (nowact == 3)
                {
                    if (movcnt < movlmt)
                    {
                        resetlockdl(0);
                        ++movcnt;
                    } // end if
                } // end if
            }
            else
            {
                kcml = movedl;
            } // end else if
        }
        else if (isoknp(0, -1, 0))
        {
            _loc1 = 1;
        } // end else if
        kcml = kcml >= movedl ? (kcml) : (kcml + 1);
    } // end else if
    if (kpmr == 0)
    {
        kcmr = 0;
    }
    else if (kpmr == 1)
    {
        if (kcmr == 0)
        {
            if (kpml == 1)
            {
                kcml = movedl + 1;
                kcmr = 1;
            }
            else
            {
                kcmr = 1;
            } // end else if
        }
        else if (kcmr == movedl + 1 && kpml == 0)
        {
            kcmr = movedl;
        } // end else if
        if (kcmr == 1 || kcmr == movedl)
        {
            if (isoknp(0, 1, 0))
            {
                ++nbx;
                _loc1 = 1;
                if (nowact == 3)
                {
                    if (movcnt < movlmt)
                    {
                        resetlockdl(0);
                        ++movcnt;
                    } // end if
                } // end if
            }
            else
            {
                kcmr = movedl;
            } // end else if
        }
        else if (isoknp(0, 1, 0))
        {
            _loc1 = 1;
        } // end else if
        kcmr = kcmr >= movedl ? (kcmr) : (kcmr + 1);
    } // end else if
    paintsplash(nbs, nbr, nbx, nby);
    if (_loc1 != 1)
    {
        if (kcml != movedl + 1 && kpml == 1)
        {
            return (-1);
        } // end if
        if (kcmr != movedl + 1 && kpmr == 1)
        {
            return (1);
        } // end if
    } // end if
    return (0);
} // End of the function
function holdb(bisinf)
{
    var _loc1;
    if (kphd == 0)
    {
        kchd = 0;
    } // end if
    if (shold == 1 && justhold == 0)
    {
        if (bisinf == 1)
        {
            if (kphd == 1 && kchd == 0)
            {
                kchd = 2;
                justhold = 1;
                if (holdblx == 0)
                {
                    holdblx = nbs;
                    nbs = nextblx[0];
                    makenext();
                }
                else
                {
                    _loc1 = holdblx;
                    holdblx = nbs;
                    nbs = _loc1;
                } // end else if
                playsfx(sfxhold);
                makenew();
            } // end if
        }
        else if (kphd == 1 && kchd == 0)
        {
            kchd = 2;
            justhold = 1;
            if (holdblx == 0)
            {
                holdblx = nextblx[0];
                makenext();
            }
            else
            {
                _loc1 = holdblx;
                holdblx = nextblx[0];
                nextblx[0] = _loc1;
            } // end else if
            playsfx(sfxhold);
        } // end if
    } // end else if
} // End of the function
function fallb(blocks, notreallydo)
{
    var _loc1;
    if (notreallydo == 0)
    {
        for (var _loc1 = 0; _loc1 < blocks; ++_loc1)
        {
            paintsplash(nbs, nbr, nbx, nby + _loc1);
            if (!isok(nbs, nbr, nbx, nby + _loc1 + 1))
            {
                nby = nby + _loc1;
                if (maxx < nby || nowact == 2)
                {
                    maxx = nby;
                    resetlockdl(0);
                } // end if
                resetlockdl(1);
                nowact = 3;
                return (nby);
            } // end if
        } // end of for
        nby = nby + _loc1;
        return (nby);
    }
    else
    {
        for (var _loc1 = 0; _loc1 < blocks; ++_loc1)
        {
            if (!isok(nbs, nbr, nbx, nby + _loc1 + 1))
            {
                return (nby + _loc1);
            } // end if
        } // end of for
        return (nby + _loc1);
    } // end else if
} // End of the function
function changebg(lvl)
{
    bgny = -bgmy / 21 * (20 - lvl) - Math.random() * bgmy / 21;
    bgnx = -Math.random() * bgmx;
    bgty = -bgmy / 21 * (20 - lvl) - Math.random() * bgmy / 21;
    bgtx = -Math.random() * bgmx;
    bggamemc._x = bgnx;
    bggamemc._y = bgny;
    return (0);
} // End of the function
function die()
{
    if (nscore > highest && cheat == 0)
    {
        highest = int(nscore);
        submitted = 0;
    } // end if
    playbgm(6);
    playing = 0;
    //com.baidu.app.as2api.APP.Game.submitScore(highest);
    goback();
} // End of the function
function goback()
{
    blkmc.removeMovieClip();
    blkmc.unloadMovie();
    keydown = 1;
    gotoAndStop(2);
    gameplaying = 0;
} // End of the function
function scorecb(d)
{
    if (data == true)
    {
        submitted = 1;
    } // end if
} // End of the function
function mochishowad()
{
    goback();
    mochi.as2.MochiAd.showInterLevelAd({id: "cc6577cacee28f9d", res: "540x480", ad_started: function ()
    {
    }, ad_finished: function ()
    {
    }});
} // End of the function
stop ();
var bgmx = 0;
var bgmy = 0;
var bgtx = 0;
var bgty = 0;
var bgnx = 0;
var bgny = 0;
bgmx = bggamemc._width - 540;
bgmy = bggamemc._height - 480;
var submitted = 0;
var cheat = 0;
var ped = 0;
var pnum = 0;
var died = 0;
var dontdispnow = 0;
var kch = 8; //backspace
var kpch = 0;
var kcch = 0;
var kps = 80;
var kpps = 0;
var kcps = 0;
var csiz = 0;
var cmut = 0;
var cdbg = 0;
var nbs = 0;
var nbr = 0;
var nbx = 0;
var nby = 0;
var holdblx = 0;
var nowact = 0;
var delayc = 0;
var kpml = 0;
var kpmr = 0;
var kpmd = 0;
var kpfd = 0;
var kprl = 0;
var kprr = 0;
var kpro = 0;
var kphd = 0;
var kcml = 0;
var kcmr = 0;
var kcmd = 0;
var kcfd = 0;
var kcrl = 0;
var kcrr = 0;
var kcro = 0;
var kchd = 0;
var nlevel = 0;
var nscore = 0;
var justhold = 0;
var nline = 0;
var movedl = 0;
var maxx = 0;
var maxup = 2;
var movlmt = 8;
var movcnt = 0;
var aofx = 134;
var aofy = 0;
var kline = 0;
var klines = new Array(22);
var histptr = 0;
var histblx = [0, 0, 0, 0];
var nextblx = new Array(3);
var xh = 0;
while (xh < 3)
{
    nextblx[xh] = 0;
    ++xh;
} // end while
var ofx = 4;
var ofy = 5;
var ablox = new Array(18);
var xh = 0;
while (xh < 18)
{
    ablox[xh] = new Array(30);
    var xh2 = 0;
    while (xh2 < 30)
    {
        ablox[xh][xh2] = 0;
        ++xh2;
    } // end while
    ++xh;
} // end while
var lvgdist = [1, 1, 1, 1, 1, 1, 1, 2, 3, 5, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20];
var lvgdelay = [60, 30, 15, 8, 4, 2, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var lvldelay = [40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 33, 28, 24, 20, 18, 15, 12, 10, 8, 20];
var newdelay = [25, 25, 25, 25, 25, 20, 20, 20, 15, 15, 20, 15, 12, 10, 10, 8, 8, 8, 6, 6, 10];
var linedelay = [35, 25, 25, 20, 20, 15, 15, 15, 15, 15, 12, 12, 12, 6, 6, 4, 4, 4, 4, 4, 4];
var movedelay = [12, 12, 12, 12, 12, 10, 10, 10, 10, 10, 8, 8, 8, 8, 8, 6, 6, 6, 5, 5, 5];
var tstyle;
//IOTJLSZ
var colors = new Array(2);
colors[0] = [0, 1, 2, 3, 4, 5, 6, 7];
colors[1] = [0, 3, 2, 6, 4, 5, 7, 1];
var initr = new Array(2);
initr[0] = [0, 0, 0, 0, 0, 0, 0, 0];
initr[1] = [2, 2, 2, 2, 2, 2, 2, 2];
var inity = new Array(2);
inity[0] = [0, 0, 0, 0, 0, 0, 0, 0];
inity[1] = [0, 0, 0, 1, 1, 1, 0, 0];
var psofx = new Array(2);
psofx[0] = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
psofx[1] = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
var psofy = new Array(2);
psofy[0] = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 1, 0], [0, 0, 1, 0], [0, 0, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
psofy[1] = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
var game = 0;
var kblox = new Array(8);
kblox[0] = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
kblox[1] = [-1, -1, -1, -1, -1, -1, -1, -1, 8, 12, 12, 4, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, 3, -1, -1, -1, 3, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 8, 12, 12, 4, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, 3, -1, -1, -1, 3, -1, -1, -1, 1, -1];
kblox[2] = [-1, -1, -1, -1, -1, -1, -1, -1, -1, 10, 6, -1, -1, 9, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 10, 6, -1, -1, 9, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 10, 6, -1, -1, 9, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 10, 6, -1, -1, 9, 5, -1];
kblox[3] = [-1, -1, -1, -1, -1, -1, -1, -1, 8, 14, 4, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, 8, 7, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, 8, 13, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, 11, 4, -1, -1, 1, -1, -1];
kblox[4] = [-1, -1, -1, -1, -1, -1, -1, -1, 10, 12, 4, -1, 1, -1, -1, -1, -1, -1, -1, -1, 8, 6, -1, -1, -1, 3, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, 2, -1, 8, 12, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, 3, -1, -1, -1, 9, 4, -1];
kblox[5] = [-1, -1, -1, -1, -1, -1, -1, -1, 8, 12, 6, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, 3, -1, -1, 8, 5, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, 9, 12, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 10, 4, -1, -1, 3, -1, -1, -1, 1, -1, -1];
kblox[6] = [-1, -1, -1, -1, -1, -1, -1, -1, -1, 10, 4, -1, 8, 5, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, 9, 6, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 10, 4, -1, 8, 5, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, 9, 6, -1, -1, -1, 1, -1, -1];
kblox[7] = [-1, -1, -1, -1, -1, -1, -1, -1, 8, 6, -1, -1, -1, 9, 4, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, 10, 5, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 8, 6, -1, -1, -1, 9, 4, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, 10, 5, -1, -1, 1, -1, -1];
var shold = 1;
var sclimb = 0;
var fblk = new Array(10);
var xh = 0;
while (xh < 10)
{
    fblk[xh] = new Array(22);
    var xh2 = 0;
    while (xh2 < 22)
    {
        fblk[xh][xh2] = -1;
        ++xh2;
    } // end while
    ++xh;
} // end while
var sblk = new Array(10);
var xh = 0;
while (xh < 10)
{
    sblk[xh] = new Array(22);
    var xh2 = 0;
    while (xh2 < 22)
    {
        sblk[xh][xh2] = -1;
        ++xh2;
    } // end while
    ++xh;
} // end while
var sblkt = new Array(10);
var xh = 0;
while (xh < 10)
{
    sblkt[xh] = new Array(22);
    var xh2 = 0;
    while (xh2 < 22)
    {
        sblkt[xh][xh2] = 0;
        ++xh2;
    } // end while
    ++xh;
} // end while
if (blkmc)
{
    blkmc.removeMovieClip();
    blkmc.unloadMovie();
}
var blkmc = this.createEmptyMovieClip("blk", this.getNextHighestDepth());
var mblk = new Array(10);
var xh = 0;
while (xh < 10)
{
    mblk[xh] = new Array(22);
    var xh2 = 0;
    while (xh2 < 22)
    {
        var dep = blkmc.getNextHighestDepth();
        mblk[xh][xh2] = blkmc.attachMovie("block", "block" + dep, dep);
        mblk[xh][xh2]._x = xh * 16 + 8 + aofx;
        mblk[xh][xh2]._y = xh2 * 16 + 80 + aofy;
        ++xh2;
    } // end while
    ++xh;
} // end while
var mhld = new Array(16);
var mnxt = new Array(3);
mnxt[0] = new Array(16);
mnxt[1] = new Array(16);
mnxt[2] = new Array(16);
var xh = 0;
while (xh < 4)
{
    var xh2 = 0;
    while (xh2 < 4)
    {
        var dep = blkmc.getNextHighestDepth();
        mhld[xh + xh2 * 4] = blkmc.attachMovie("block", "block" + dep, dep);
        mhld[xh + xh2 * 4]._x = xh * 8 + 4 + aofx;
        mhld[xh + xh2 * 4]._y = xh2 * 8 + 48 + aofy;
        mhld[xh + xh2 * 4]._height = 8;
        mhld[xh + xh2 * 4]._width = 8;
        dep = blkmc.getNextHighestDepth();
        mnxt[0][xh + xh2 * 4] = blkmc.attachMovie("block", "block" + dep, dep);
        mnxt[0][xh + xh2 * 4]._x = xh * 16 + 56 + aofx;
        mnxt[0][xh + xh2 * 4]._y = xh2 * 16 + 24 + aofy;
        dep = blkmc.getNextHighestDepth();
        mnxt[1][xh + xh2 * 4] = blkmc.attachMovie("block", "block" + dep, dep);
        mnxt[1][xh + xh2 * 4]._x = xh * 8 + 120 + aofx;
        mnxt[1][xh + xh2 * 4]._y = xh2 * 8 + 48 + aofy;
        mnxt[1][xh + xh2 * 4]._height = 8;
        mnxt[1][xh + xh2 * 4]._width = 8;
        dep = blkmc.getNextHighestDepth();
        mnxt[2][xh + xh2 * 4] = blkmc.attachMovie("block", "block" + dep, dep);
        mnxt[2][xh + xh2 * 4]._x = xh * 8 + 152 + aofx;
        mnxt[2][xh + xh2 * 4]._y = xh2 * 8 + 48 + aofy;
        mnxt[2][xh + xh2 * 4]._height = 8;
        mnxt[2][xh + xh2 * 4]._width = 8;
        ++xh2;
    } // end while
    ++xh;
} // end while
var txt = blkmc.createTextField("txtf", blkmc.getNextHighestDepth(), aofx + 176, aofy + 96, 128, 384);
txt.selectable = false;
txt.textColor = 16768256;
var time1;
var time2;
var sttime;
var time1s = 0;
var fps = 0;
var ffps = 0;
var f2rf = 0;
var curfps = 0;
var curffps = 0;
var frmdl = 1.666667E+001;
var frmtime = 0;
var time = new Date();
var xh = 0;
while (xh < 20)
{
    delaydisp[xh] = 0;
    ++xh;
} // end while
time1 = time.getTime();
time2 = time1;
time1s = time1;
init();
var wktbl = new Array(3);
var wktblc = [7, 8, 8];
wktbl[0] = [[0, 0], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [0, -1]];
wktbl[1] = [[1, 0], [1, 1], [2, 0], [0, 0], [0, 1], [0, -1], [-1, 1], [-1, 0]];
wktbl[2] = [[-1, 0], [-1, 1], [0, 1], [-1, 2], [0, 0], [0, -1], [1, 0], [1, 1]]; 

import {LightningElement} from 'lwc';
import getUpcomingSongs from '@salesforce/apex/LandingPageController.getUpcomingSongs';   
import getNewSongs from '@salesforce/apex/LandingPageController.getNewSongs';
import getAlbumes from '@salesforce/apex/LandingPageController.getAlbumes';     

export default class SpotifyLandingPage extends LightningElement {

    upcomingSongs;
    newSongs;
    albumes;
    error;
    playlist_Main;
    playlist_Private;
    playlist_Public;

    async connectedCallback(){

        let myLetVariable = 'test';
        const myConstVariable = 'test';

        try {
            this.upcomingSongs = await getUpcomingSongs();
            this.newSongs = await getNewSongs();
            this.albumes = await getAlbumes();
            this.playlist_Main = await getMainPlaylist();
            this.playlist_Private = await getPlaylistPrivate();
            this.playlist_Public = await getPlaylistPublic();
        } catch (e) {
            this.error = e;
        }
    }
}
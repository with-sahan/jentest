package com.mdl.mdlrestapi.psm.exception;

/**
 * The Class ApacheFopException.
 *
 * @version $Id: $
 */
public class ApacheFopException extends RuntimeException {

	// ===========================================
	// Public Members
	// ===========================================

	// ===========================================
	// Private Members
	// ===========================================

	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 4599918942963563839L;

	// ===========================================
	// Static initialisers
	// ===========================================

	// ===========================================
	// Constructors
	// ===========================================

	/**
	 * Instantiates a new apache fop exception.
	 */
	public ApacheFopException() {
		super();
	}

	/**
	 * Instantiates a new apache fop exception.
	 *
	 * @param message the message
	 * @param cause the cause
	 * @param enableSuppression the enable suppression
	 * @param writableStackTrace the writable stack trace
	 */
	public ApacheFopException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	/**
	 * Instantiates a new apache fop exception.
	 *
	 * @param message the message
	 * @param cause the cause
	 */
	public ApacheFopException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * Instantiates a new apache fop exception.
	 *
	 * @param message the message
	 */
	public ApacheFopException(String message) {
		super(message);
	}

	/**
	 * Instantiates a new apache fop exception.
	 *
	 * @param cause the cause
	 */
	public ApacheFopException(Throwable cause) {
		super(cause);
	}

	// ===========================================
	// Public Methods
	// ===========================================

	// ===========================================
	// Protected Methods
	// ===========================================

	// ===========================================
	// Private Methods
	// ===========================================

}
